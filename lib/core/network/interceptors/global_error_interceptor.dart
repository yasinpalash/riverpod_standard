import 'package:dio/dio.dart';
import 'package:riverpod_standard/core/logging/logging.dart';
import 'package:riverpod_standard/core/monitoring/error_reporter.dart';
import 'package:riverpod_standard/core/network/events/network_event.dart';
import 'package:riverpod_standard/core/network/events/network_event_bus.dart';

class GlobalErrorInterceptor extends Interceptor {
  GlobalErrorInterceptor({
    required NetworkEventBus eventBus,
    required ErrorReporter errorReporter,
  }) : _eventBus = eventBus,
       _errorReporter = errorReporter;

  final NetworkEventBus _eventBus;
  final ErrorReporter _errorReporter;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final statusCode = err.response?.statusCode;
    final endpoint = err.requestOptions.path;
    final message = _messageFrom(err);

    AppLogger.error(
      'Dio request failed',
      error: err,
      stackTrace: err.stackTrace,
    );

    await _errorReporter.captureException(
      err,
      stackTrace: err.stackTrace,
      context: {
        'endpoint': endpoint,
        'method': err.requestOptions.method,
        'statusCode': statusCode,
      },
    );

    if (statusCode == 401) {
      _eventBus.publish(
        NetworkEvent(
          type: NetworkEventType.unauthorized,
          message: 'Your session has expired. Please login again.',
          statusCode: statusCode,
          endpoint: endpoint,
        ),
      );
    } else if (statusCode != null && statusCode >= 500) {
      _eventBus.publish(
        NetworkEvent(
          type: NetworkEventType.serverError,
          message: message,
          statusCode: statusCode,
          endpoint: endpoint,
        ),
      );
    }

    handler.next(err);
  }

  String _messageFrom(DioException err) {
    final data = err.response?.data;
    if (data is Map<String, dynamic>) {
      final message = data['message'];
      if (message is String && message.isNotEmpty) {
        return message;
      }
    }

    return err.message ?? 'Something went wrong. Please try again.';
  }
}
