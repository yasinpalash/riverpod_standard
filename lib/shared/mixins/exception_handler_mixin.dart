import 'dart:developer';

import 'package:riverpod_standard/shared/data/remote/network_service.dart';
import 'package:riverpod_standard/shared/domain/models/either.dart';
import 'package:riverpod_standard/shared/exceptions/http_exception.dart';
import '../domain/models/response.dart' as response;
import 'package:dio/dio.dart';

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
    } catch (e) {
      String message = '';
      String identifier = '';
      int statusCode = 0;
      log(e.runtimeType.toString());
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
