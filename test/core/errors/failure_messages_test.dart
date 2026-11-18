import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_standard/core/constants/app_strings.dart';
import 'package:riverpod_standard/core/errors/failure_code.dart';
import 'package:riverpod_standard/core/errors/failure_messages.dart';
import 'package:riverpod_standard/core/errors/failures.dart';

void main() {
  group('FailureCode.fromStatusCode', () {
    test('maps known statuses', () {
      expect(FailureCode.fromStatusCode(400), FailureCode.badRequest);
      expect(FailureCode.fromStatusCode(401), FailureCode.unauthorized);
      expect(FailureCode.fromStatusCode(404), FailureCode.notFound);
      expect(FailureCode.fromStatusCode(503), FailureCode.server);
      expect(FailureCode.fromStatusCode(null), FailureCode.unknown);
    });
  });

  group('Failure.userMessage', () {
    test('shows the backend message for client/server errors', () {
      const failure = Failure(
        code: FailureCode.badRequest,
        serverMessage: 'Invalid credentials',
      );
      expect(failure.userMessage, 'Invalid credentials');
    });

    test('falls back to a code-based message without a server message', () {
      const failure = Failure(code: FailureCode.noConnection);
      expect(failure.userMessage, AppStrings.noInternetConnection);
    });

    test('never shows diagnostic text for unknown failures', () {
      const failure = Failure(
        code: FailureCode.unknown,
        serverMessage: 'stack trace here',
        identifier: 'DioException ...',
      );
      expect(failure.userMessage, AppStrings.somethingWentWrong);
    });
  });
}
