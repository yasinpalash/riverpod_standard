import 'package:riverpod_standard/core/errors/exceptions.dart';
import 'package:riverpod_standard/shared/models/either.dart';

class BaseResponse {
  final int statusCode;
  final String? statusMessage;
  final dynamic data;

  BaseResponse({
    required this.statusCode,
    this.statusMessage,
    this.data = const {},
  });

  @override
  String toString() {
    return 'statusCode=$statusCode\nstatusMessage=$statusMessage\n data=$data';
  }
}

extension ResponseExtension on BaseResponse {
  Right<AppException, BaseResponse> get toRight => Right(this);
}
