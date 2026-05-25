
class AppHelper {
  AppHelper._();

  static bool isBlank(String? value) {
    return value == null || value.trim().isEmpty;
  }

  static String normalizeWhitespace(String value) {
    return value.trim().replaceAll(RegExp(r'\s+'), ' ');
  }

  static String? nullIfBlank(String? value) {
    final trimmedValue = value?.trim();
    if (trimmedValue == null || trimmedValue.isEmpty) {
      return null;
    }
    return trimmedValue;
  }

}
