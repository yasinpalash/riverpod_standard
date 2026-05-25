import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:riverpod_standard/core/logging/logging.dart';
import 'package:riverpod_standard/shared/domain/models/either.dart';
import 'package:riverpod_standard/shared/exceptions/http_exception.dart';
import 'package:riverpod_standard/shared/data/remote/remote.dart';
import '../../../shared/domain/models/response.dart' as response;

mixin ExceptionHandlerMixin on NetworkService {
  Future<Either<AppException, response.Response>>
  handleException<T extends Object>(
    Future<Response<dynamic>> Function() handler, {
    String endpoint = '',
  }) async {
    try {
      final res = await handler();
      return Right(
        response.Response(
          statusCode: res.statusCode ?? 200,
          data: res.data,
          statusMessage: res.statusMessage,
        ),
      );
    } catch (e, stackTrace) {
      String message = '';
      String identifier = '';
      int statusCode = 0;

      AppLogger.error(
        'Network request failed at $endpoint',
        error: e,
        stackTrace: stackTrace,
      );

      if (e is SocketException) {
        message = 'Unable to connect to the server.';
        statusCode = 0;
        identifier = 'SocketException ${e.message}\nat $endpoint';
      } else if (e is DioException) {
        final responseData = e.response?.data;
        final responseMessage =
            responseData is Map<String, dynamic>
                ? responseData['message']?.toString()
                : null;
        message = responseMessage ?? e.message ?? 'Internal error occurred';
        statusCode = e.response?.statusCode ?? 1;
        identifier = 'DioException ${e.message}\nat $endpoint';
      } else {
        message = 'Unknown error occurred';
        statusCode = 2;
        identifier = 'Unknown error ${e.toString()}\nat $endpoint';
      }

      return Left(
        AppException(
          message: message,
          statusCode: statusCode,
          identifier: identifier,
        ),
      );
    }
  }
}
