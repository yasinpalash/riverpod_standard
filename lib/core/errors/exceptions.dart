import 'package:equatable/equatable.dart';
import 'package:riverpod_standard/core/constants/app_strings.dart';

class AppException implements Exception {
  final String message;
  final int statusCode;
  final String identifier;

  AppException({
    required this.message,
    required this.statusCode,
    required this.identifier,
  });

  @override
  String toString() {
    return 'statusCode=$statusCode\nmessage=$message\nidentifier=$identifier';
  }
}

class CacheFailureException extends Equatable implements AppException {
  @override
  String get identifier => 'Cache failure exception';

  @override
  String get message => 'Unable to save user';

  @override
  int get statusCode => 100;

  @override
  List<Object?> get props => [message, statusCode, identifier];
}

class NoInternetException extends Equatable implements AppException {
  @override
  String get identifier => 'No internet connection';

  @override
  String get message => AppStrings.noInternetConnection;

  @override
  int get statusCode => 0;

  @override
  List<Object?> get props => [message, statusCode, identifier];
}
