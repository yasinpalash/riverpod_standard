/// Transport-independent category of a failure. UI and logic branch on this,
/// never on message text or magic status numbers.
enum FailureCode {
  badRequest,
  unauthorized,
  forbidden,
  notFound,
  timeout,
  server,
  noConnection,
  cache,
  cancelled,
  unknown;

  static FailureCode fromStatusCode(int? statusCode) {
    if (statusCode == null) return FailureCode.unknown;
    if (statusCode >= 500) return FailureCode.server;
    return switch (statusCode) {
      400 => FailureCode.badRequest,
      401 => FailureCode.unauthorized,
      403 => FailureCode.forbidden,
      404 => FailureCode.notFound,
      408 => FailureCode.timeout,
      _ => FailureCode.unknown,
    };
  }
}
