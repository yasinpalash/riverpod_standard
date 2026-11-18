import 'package:riverpod_standard/core/errors/failure_code.dart';

/// Data-layer exception. Thrown by datasources, mapped to a `Failure` by
/// `ExceptionMapper`. [message] is the backend-provided text (may be empty);
/// [identifier] is diagnostic only and is never shown to users.
class AppException implements Exception {
  AppException({
    this.message = '',
    this.statusCode = 0,
    this.identifier = '',
    FailureCode? code,
  }) : code = code ?? FailureCode.fromStatusCode(statusCode);

  final String message;
  final int statusCode;
  final String identifier;
  final FailureCode code;

  @override
  String toString() =>
      'AppException(code=$code, statusCode=$statusCode, message=$message, '
      'identifier=$identifier)';
}

class CacheFailureException extends AppException {
  CacheFailureException({super.identifier = 'Cache failure'})
    : super(code: FailureCode.cache);
}

class NoInternetException extends AppException {
  NoInternetException({super.identifier = 'No internet connection'})
    : super(code: FailureCode.noConnection);
}
