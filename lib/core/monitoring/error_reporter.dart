abstract class ErrorReporter {
  Future<void> captureException(
    Object error, {
    StackTrace? stackTrace,
    Map<String, Object?> context = const {},
  });
}

class NoopErrorReporter implements ErrorReporter {
  const NoopErrorReporter();

  @override
  Future<void> captureException(
    Object error, {
    StackTrace? stackTrace,
    Map<String, Object?> context = const {},
  }) async {}
}
