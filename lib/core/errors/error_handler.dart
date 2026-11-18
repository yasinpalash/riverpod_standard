import 'dart:io';

import 'package:dio/dio.dart';
import 'package:riverpod_standard/core/errors/exceptions.dart';
import 'package:riverpod_standard/core/errors/failure_code.dart';
import 'package:riverpod_standard/core/logging/logging.dart';
import 'package:riverpod_standard/core/network/api_response_parser.dart';
import 'package:riverpod_standard/core/result/either.dart';

mixin ErrorHandler {
  Future<Either<AppException, T>> handleException<T>(
    Future<Response<dynamic>> Function() handler, {
    String endpoint = '',
    required JsonParser<T> parser,
    bool unwrapEnvelope = false,
  }) async {
    try {
      final res = await handler();
      final parsed = ApiResponseParser.parse<T>(
        res,
        parser: parser,
        unwrapEnvelope: unwrapEnvelope,
      );
      return Right(parsed);
    } catch (e, stackTrace) {
      AppLogger.error(
        'Network request failed at $endpoint',
        error: e,
        stackTrace: stackTrace,
      );
      return Left(_toException(e, endpoint));
    }
  }

  AppException _toException(Object e, String endpoint) {
    if (e is AppException) {
      return AppException(
        message: e.message,
        statusCode: e.statusCode,
        identifier: '${e.identifier}\nat $endpoint',
        code: e.code,
      );
    }
    if (e is SocketException) {
      return AppException(
        code: FailureCode.noConnection,
        identifier: 'SocketException ${e.message}\nat $endpoint',
      );
    }
    if (e is DioException) {
      final inner = e.error;
      if (inner is AppException) return _toException(inner, endpoint);
      final status = e.response?.statusCode;
      final code = switch (e.type) {
        DioExceptionType.connectionTimeout ||
        DioExceptionType.sendTimeout ||
        DioExceptionType.receiveTimeout => FailureCode.timeout,
        DioExceptionType.connectionError => FailureCode.noConnection,
        DioExceptionType.cancel => FailureCode.cancelled,
        _ => FailureCode.fromStatusCode(status),
      };
      final data = e.response?.data;
      final serverMessage =
          data is Map<String, dynamic> ? data['message']?.toString() : null;
      return AppException(
        message: serverMessage ?? '',
        statusCode: status ?? 0,
        identifier: 'DioException ${e.message}\nat $endpoint',
        code: code,
      );
    }
    return AppException(
      code: FailureCode.unknown,
      identifier: 'Unknown error $e\nat $endpoint',
    );
  }
}
