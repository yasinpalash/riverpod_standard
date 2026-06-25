import 'package:dio/dio.dart';
import 'package:riverpod_standard/core/constants/api_constants.dart';
import 'package:riverpod_standard/core/constants/app_constants.dart';
import 'package:riverpod_standard/core/errors/error_handler.dart';
import 'package:riverpod_standard/core/errors/exceptions.dart';
import 'package:riverpod_standard/core/monitoring/error_reporter.dart';
import 'package:riverpod_standard/core/network/api_response_parser.dart';
import 'package:riverpod_standard/core/network/api_service.dart';
import 'package:riverpod_standard/core/network/events/network_event_bus.dart';
import 'package:riverpod_standard/core/network/interceptors/auth_interceptor.dart';
import 'package:riverpod_standard/core/network/interceptors/connectivity_interceptor.dart';
import 'package:riverpod_standard/core/network/interceptors/global_error_interceptor.dart';
import 'package:riverpod_standard/core/services/connectivity_service.dart';
import 'package:riverpod_standard/core/storage/local_storage_service.dart';
import 'package:riverpod_standard/shared/models/either.dart';

class ApiClient with ErrorHandler implements ApiService {
  ApiClient({
    required this.baseUrl,
    required bool enableLogging,
    required Duration connectTimeout,
    required Duration receiveTimeout,
    ConnectivityService? connectivityService,
    LocalStorageService? storageService,
    NetworkEventBus? networkEventBus,
    ErrorReporter? errorReporter,
    Dio? dio,
  }) : dio = dio ?? Dio() {
    this.dio.options = BaseOptions(
      baseUrl: baseUrl,
      headers: headers,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
    );

    if (AppConstants.isTestMode) return;

    if (connectivityService != null) {
      this.dio.interceptors.add(ConnectivityInterceptor(connectivityService));
    }
    if (storageService != null) {
      this.dio.interceptors.add(AuthInterceptor(storageService));
    }
    if (networkEventBus != null && errorReporter != null) {
      this.dio.interceptors.add(
        GlobalErrorInterceptor(
          eventBus: networkEventBus,
          errorReporter: errorReporter,
        ),
      );
    }
    if (enableLogging) {
      this.dio.interceptors.add(
        LogInterceptor(requestBody: true, responseBody: true),
      );
    }
  }

  final Dio dio;

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
    dio.options.headers = header;
    return header;
  }

  @override
  Future<Either<AppException, T>> get<T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    required JsonParser<T> parser,
    bool unwrapEnvelope = false,
  }) {
    return handleException<T>(
      () => dio.get(endpoint, queryParameters: queryParameters),
      endpoint: endpoint,
      parser: parser,
      unwrapEnvelope: unwrapEnvelope,
    );
  }

  @override
  Future<Either<AppException, T>> post<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    required JsonParser<T> parser,
    bool unwrapEnvelope = false,
  }) {
    return handleException<T>(
      () => dio.post(endpoint, data: data, queryParameters: queryParameters),
      endpoint: endpoint,
      parser: parser,
      unwrapEnvelope: unwrapEnvelope,
    );
  }

  @override
  Future<Either<AppException, T>> put<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    required JsonParser<T> parser,
    bool unwrapEnvelope = false,
  }) {
    return handleException<T>(
      () => dio.put(endpoint, data: data, queryParameters: queryParameters),
      endpoint: endpoint,
      parser: parser,
      unwrapEnvelope: unwrapEnvelope,
    );
  }

  @override
  Future<Either<AppException, T>> patch<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    required JsonParser<T> parser,
    bool unwrapEnvelope = false,
  }) {
    return handleException<T>(
      () => dio.patch(endpoint, data: data, queryParameters: queryParameters),
      endpoint: endpoint,
      parser: parser,
      unwrapEnvelope: unwrapEnvelope,
    );
  }

  @override
  Future<Either<AppException, T>> delete<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    required JsonParser<T> parser,
    bool unwrapEnvelope = false,
  }) {
    return handleException<T>(
      () => dio.delete(endpoint, data: data, queryParameters: queryParameters),
      endpoint: endpoint,
      parser: parser,
      unwrapEnvelope: unwrapEnvelope,
    );
  }
}
