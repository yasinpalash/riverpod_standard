import 'package:dio/dio.dart';
import 'package:riverpod_standard/core/logging/app_logger.dart';
import 'package:riverpod_standard/core/logging/log_redactor.dart';

/// Replacement for Dio's `LogInterceptor` that never prints credentials:
/// headers and bodies pass through [LogRedactor] first.
class RedactedLogInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    AppLogger.debug(
      '--> ${options.method} ${options.uri}\n'
      'headers: ${LogRedactor.redact(options.headers)}\n'
      'body: ${LogRedactor.redactAndTruncate(options.data)}',
    );
    handler.next(options);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    AppLogger.debug(
      '<-- ${response.statusCode} ${response.requestOptions.uri}\n'
      'body: ${LogRedactor.redactAndTruncate(response.data)}',
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    AppLogger.debug(
      '<-- ERROR ${err.response?.statusCode ?? err.type.name} '
      '${err.requestOptions.uri}\n'
      'body: ${LogRedactor.redactAndTruncate(err.response?.data)}',
    );
    handler.next(err);
  }
}
