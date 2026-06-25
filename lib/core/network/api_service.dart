import 'package:riverpod_standard/core/errors/exceptions.dart';
import 'package:riverpod_standard/core/network/api_response_parser.dart';
import 'package:riverpod_standard/shared/models/either.dart';

abstract class ApiService {
  String get baseUrl;
  Map<String, Object> get headers;
  Map<String, dynamic>? updateHeader(Map<String, dynamic> data);

  Future<Either<AppException, T>> get<T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    required JsonParser<T> parser,
    bool unwrapEnvelope = false,
  });

  Future<Either<AppException, T>> post<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    required JsonParser<T> parser,
    bool unwrapEnvelope = false,
  });

  Future<Either<AppException, T>> put<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    required JsonParser<T> parser,
    bool unwrapEnvelope = false,
  });

  Future<Either<AppException, T>> patch<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    required JsonParser<T> parser,
    bool unwrapEnvelope = false,
  });

  Future<Either<AppException, T>> delete<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    required JsonParser<T> parser,
    bool unwrapEnvelope = false,
  });
}
