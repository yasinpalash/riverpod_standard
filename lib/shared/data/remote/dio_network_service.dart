import 'package:dio/dio.dart';
import 'package:riverpod_standard/shared/data/remote/network_service.dart';
import 'package:riverpod_standard/shared/domain/models/either.dart';
import 'package:riverpod_standard/shared/exceptions/http_exception.dart';
import '../../../core/utils/mixins/exception_handler_mixin.dart';
import '../../domain/models/response.dart' as response;
import '../../globals.dart';

class DioNetworkService extends NetworkService with ExceptionHandlerMixin {
  DioNetworkService(
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
    'accept': 'application/json',
    'content-type': 'application/json',
  };
  @override
  Map<String, dynamic>? updateHeader(Map<String, dynamic> data) {
    final header = {...data, ...headers};
    if (!kTestMode) {
      dio.options.headers = header;
    }
    return header;
  }

  @override
  Future<Either<AppException, response.Response>> get(
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
  Future<Either<AppException, response.Response>> post(
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
