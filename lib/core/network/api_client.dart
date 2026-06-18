import 'package:dio/dio.dart';
import 'package:riverpod_standard/core/constants/api_constants.dart';
import 'package:riverpod_standard/core/constants/app_constants.dart';
import 'package:riverpod_standard/core/errors/error_handler.dart';
import 'package:riverpod_standard/core/errors/exceptions.dart';
import 'package:riverpod_standard/core/monitoring/error_reporter.dart';
import 'package:riverpod_standard/core/network/events/network_event_bus.dart';
import 'package:riverpod_standard/core/network/interceptors/auth_interceptor.dart';
import 'package:riverpod_standard/core/network/interceptors/connectivity_interceptor.dart';
import 'package:riverpod_standard/core/network/interceptors/global_error_interceptor.dart';
import 'package:riverpod_standard/core/network/api_service.dart';
import 'package:riverpod_standard/core/services/connectivity_service.dart';
import 'package:riverpod_standard/core/storage/local_storage_service.dart';
import 'package:riverpod_standard/shared/models/either.dart';
import 'package:riverpod_standard/shared/models/base_response.dart';

class ApiClient extends ApiService with ErrorHandler {
  ApiClient(
    this.dio, {
    required this.baseUrl,
    required this.enableLogging,
    required this.connectTimeout,
    required this.receiveTimeout,
    ConnectivityService? connectivityService,
    LocalStorageService? storageService,
    NetworkEventBus? networkEventBus,
    ErrorReporter? errorReporter,
  }) {
    if (!AppConstants.isTestMode) {
      dio.options = dioBaseOptions;
      if (connectivityService != null) {
        dio.interceptors.add(ConnectivityInterceptor(connectivityService));
      }
      if (storageService != null) {
        dio.interceptors.add(AuthInterceptor(storageService));
      }
      if (networkEventBus != null && errorReporter != null) {
        dio.interceptors.add(
          GlobalErrorInterceptor(
            eventBus: networkEventBus,
            errorReporter: errorReporter,
          ),
        );
      }
      if (enableLogging) {
        dio.interceptors.add(
          LogInterceptor(requestBody: true, responseBody: true),
        );
      }
    }
  }

  final Dio dio;
  final bool enableLogging;
  final Duration connectTimeout;
  final Duration receiveTimeout;

  BaseOptions get dioBaseOptions => BaseOptions(
    baseUrl: baseUrl,
    headers: headers,
    connectTimeout: connectTimeout,
    receiveTimeout: receiveTimeout,
  );

  @override
  final String baseUrl;

  @override
  Map<String, Object> get headers => {
    ApiConstants.acceptHeader: ApiConstants.jsonMimeType,
    ApiConstants.contentTypeHeader: ApiConstants.jsonMimeType,
  };

  @override
  Map<String, dynamic>? updateHeader(Map<String, dynamic> data) {
    final header = {...headers, ...data};
    if (!AppConstants.isTestMode) {
      dio.options.headers = header;
    }
    return header;
  }

  @override
  Future<Either<AppException, BaseResponse>> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) {
    final res = handleException(
      () => dio.get(endpoint, queryParameters: queryParameters),
      endpoint: endpoint,
    );
    return res;
  }

  @override
  Future<Either<AppException, BaseResponse>> post(
    String endpoint, {
    Map<String, dynamic>? data,
  }) {
    final res = handleException(
      () => dio.post(endpoint, data: data),
      endpoint: endpoint,
    );
    return res;
  }
}
