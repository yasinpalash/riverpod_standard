import 'package:riverpod_standard/core/constants/app_strings.dart';
import 'package:riverpod_standard/core/errors/failure_code.dart';
import 'package:riverpod_standard/core/errors/failures.dart';

extension FailureMessage on Failure {
  /// Text safe to show to users: the backend message for client/server errors
  /// when present, otherwise a message chosen by [code].
  String get userMessage {
    final server = serverMessage;
    if (server != null && server.isNotEmpty && _showsServerMessage) {
      return server;
    }
    return switch (code) {
      FailureCode.badRequest => AppStrings.badRequestError,
      FailureCode.unauthorized => AppStrings.sessionExpired,
      FailureCode.forbidden => AppStrings.accessDenied,
      FailureCode.notFound => AppStrings.notFoundError,
      FailureCode.timeout => AppStrings.requestTimedOut,
      FailureCode.server => AppStrings.serverError,
      FailureCode.noConnection => AppStrings.noInternetConnection,
      FailureCode.cache => AppStrings.unableToSaveSession,
      FailureCode.cancelled => AppStrings.requestCancelled,
      FailureCode.unknown => AppStrings.somethingWentWrong,
    };
  }

  bool get _showsServerMessage => switch (code) {
    FailureCode.badRequest ||
    FailureCode.unauthorized ||
    FailureCode.forbidden ||
    FailureCode.notFound ||
    FailureCode.server => true,
    _ => false,
  };
}
