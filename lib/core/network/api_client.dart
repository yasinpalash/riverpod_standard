import 'package:dio/dio.dart';
import 'package:riverpod_standard/core/constants/api_constants.dart';
import 'package:riverpod_standard/core/errors/error_handler.dart';
import 'package:riverpod_standard/core/errors/exceptions.dart';
import 'package:riverpod_standard/core/network/api_service.dart';
import 'package:riverpod_standard/shared/domain/models/either.dart';
import 'package:riverpod_standard/shared/globals.dart';
import 'package:riverpod_standard/shared/models/base_response.dart';

class ApiClient extends ApiService with ErrorHandler {
  ApiClient(
    this.dio, {
    required this.baseUrl,
    required this.enableLogging,
    required this.connectTimeout,
    required this.receiveTimeout,
  }) {
    if (!kTestMode) {
      dio.options = dioBaseOptions;
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
    if (!kTestMode) {
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
