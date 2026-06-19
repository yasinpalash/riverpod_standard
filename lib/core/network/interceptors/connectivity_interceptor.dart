import 'package:dio/dio.dart';
import 'package:riverpod_standard/core/errors/exceptions.dart';
import 'package:riverpod_standard/core/services/connectivity_service.dart';

class ConnectivityInterceptor extends Interceptor {
  ConnectivityInterceptor(this._connectivityService);

  final ConnectivityService _connectivityService;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final hasConnection = await _connectivityService.hasConnection;

    if (!hasConnection) {
      handler.reject(
        DioException(
          requestOptions: options,
          error: NoInternetException(),
          type: DioExceptionType.connectionError,
        ),
      );
      return;
    }

    handler.next(options);
  }
}
