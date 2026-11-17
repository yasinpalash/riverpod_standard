import 'package:riverpod_standard/core/errors/exceptions.dart';
import 'package:riverpod_standard/core/errors/failures.dart';
import 'package:riverpod_standard/core/result/either.dart';
import 'package:riverpod_standard/core/typedefs/typedefs.dart';

/// Maps data-layer exceptions to domain [Failure]s. Used by repository impls.
class ExceptionMapper {
  const ExceptionMapper._();

  static Failure toFailure(Object error) {
    if (error is Failure) return error;
    if (error is AppException) {
      return Failure(
        message: error.message,
        statusCode: error.statusCode,
        identifier: error.identifier,
      );
    }
    return Failure(
      message: 'Unknown error occurred',
      statusCode: 2,
      identifier: 'Unknown error $error',
    );
  }

  /// Runs [action], returning its value or the mapped [Failure].
  static ResultFuture<T> guard<T>(Future<T> Function() action) async {
    try {
      return Right(await action());
    } catch (e) {
      return Left(toFailure(e));
    }
  }
}
