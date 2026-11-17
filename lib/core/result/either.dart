sealed class Either<L, R> {
  const Either();
  factory Either.left(L l) => Left(l);
  factory Either.right(R r) => Right(r);

  T fold<T>(T Function(L) left, T Function(R) right) => switch (this) {
    Left(:final value) => left(value),
    Right(:final value) => right(value),
  };
  Either<L, T> map<T>(T Function(R) transform) =>
      fold<Either<L, T>>(Left.new, (r) => Right(transform(r)));

  bool isLeft() => switch (this) {
    Left() => true,
    Right() => false,
  };
  bool isRight() => !isLeft();
}

class Left<L, R> extends Either<L, R> {
  final L _l;
  const Left(this._l);
  L get value => _l;
}

class Right<L, R> extends Either<L, R> {
  final R _r;
  const Right(this._r);
  R get value => _r;
}

extension EitherUnwrap<L extends Object, R> on Either<L, R> {
  /// Returns the right value or throws the left one. For data sources.
  R getOrThrow() => fold((l) => throw l, (r) => r);
}
