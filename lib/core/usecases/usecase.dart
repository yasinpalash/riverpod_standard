import 'package:riverpod_standard/core/typedefs/typedefs.dart';

/// Base contract for every use case. [T] is the result, [P] the params.
abstract class UseCase<T, P> {
  const UseCase();
  ResultFuture<T> call(P params);
}

/// Use for use cases that take no parameters.
class NoParams {
  const NoParams();
}
