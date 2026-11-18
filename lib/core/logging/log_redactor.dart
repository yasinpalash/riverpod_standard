/// Masks credentials in text before it is logged.
class LogRedactor {
  const LogRedactor._();

  static const mask = '***';

  static final RegExp _sensitive = RegExp(
    r'''(["']?[\w-]*(?:password|token|authorization|secret|pin)[\w-]*["']?\s*[:=]\s*)'''
    r'''("[^"]*"|'[^']*'|(?:Bearer\s+)?[^\s,}\])]+)''',
    caseSensitive: false,
  );

  static String redact(Object? value) =>
      '$value'.replaceAllMapped(_sensitive, (m) => '${m[1]}$mask');

  /// Truncates after redaction so long payloads don't flood the console.
  static String redactAndTruncate(Object? value, {int maxLength = 1500}) {
    final text = redact(value);
    return text.length <= maxLength
        ? text
        : '${text.substring(0, maxLength)}… [truncated]';
  }
}
