import 'package:riverpod_standard/core/errors/exceptions.dart';
import 'package:riverpod_standard/shared/domain/models/either.dart';
import 'package:riverpod_standard/shared/models/base_response.dart';

abstract class ApiService {
  String get baseUrl;
  Map<String, Object> get headers;
  Map<String, dynamic>? updateHeader(Map<String, dynamic> data);

  Future<Either<AppException, BaseResponse>> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  });

  Future<Either<AppException, BaseResponse>> post(
    String endpoint, {
    Map<String, dynamic>? data,
  });
}
