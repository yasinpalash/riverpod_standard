extension StringX on String {
  bool get isBlank => trim().isEmpty;

  bool get isNotBlank => !isBlank;

  String get normalizedWhitespace {
    return trim().replaceAll(RegExp(r'\s+'), ' ');
  }

  String get capitalized {
    if (isBlank) {
      return '';
    }

    final value = trim();
    return value[0].toUpperCase() + value.substring(1);
  }
}

extension NullableStringX on String? {
  bool get isNullOrBlank {
    return this == null || this!.trim().isEmpty;
  }

  String? get nullIfBlank {
    final value = this?.trim();
    if (value == null || value.isEmpty) {
      return null;
    }
    return value;
  }
}
