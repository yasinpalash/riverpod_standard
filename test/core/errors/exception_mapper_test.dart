import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_standard/core/errors/exception_mapper.dart';
import 'package:riverpod_standard/core/errors/exceptions.dart';
import 'package:riverpod_standard/core/errors/failures.dart';

void main() {
  group('ExceptionMapper.guard', () {
    test('returns Right with the value on success', () async {
      final result = await ExceptionMapper.guard(() async => 42);
      expect(result.isRight(), isTrue);
      expect(result.fold((_) => null, (v) => v), 42);
    });

    test('maps AppException to Failure', () async {
      final result = await ExceptionMapper.guard<int>(
        () async =>
            throw AppException(message: 'boom', statusCode: 500, identifier: 'x'),
      );
      expect(
        result.fold((f) => f, (_) => null),
        const Failure(message: 'boom', statusCode: 500, identifier: 'x'),
      );
    });

    test('maps unknown errors to a generic Failure', () async {
      final result = await ExceptionMapper.guard<int>(
        () async => throw StateError('bad'),
      );
      final failure = result.fold((f) => f, (_) => null)!;
      expect(failure.statusCode, 2);
    });
  });
}
