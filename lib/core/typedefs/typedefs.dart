import 'package:riverpod_standard/core/errors/failures.dart';
import 'package:riverpod_standard/core/result/either.dart';

/// Async result of a domain operation: a [Failure] or a value.
typedef ResultFuture<T> = Future<Either<Failure, T>>;

/// Sync result of a domain operation.
typedef Result<T> = Either<Failure, T>;

typedef DataMap = Map<String, dynamic>;
