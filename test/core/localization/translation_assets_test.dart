import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_standard/core/localization/supported_locales.dart';

void main() {
  group('translation assets', () {
    test('each supported locale has a translation file', () {
      for (final locale in appSupportedLocales) {
        final file = File('assets/translations/${locale.languageCode}.json');

        expect(file.existsSync(), isTrue);
      }
    });

    test('all translation files expose the same keys', () {
      final referenceKeys = _translationKeysFor(appFallbackLocale.languageCode);

      for (final locale in appSupportedLocales) {
        final localeKeys = _translationKeysFor(locale.languageCode);

        expect(localeKeys.difference(referenceKeys), isEmpty);
        expect(referenceKeys.difference(localeKeys), isEmpty);
      }
    });
  });
}

Set<String> _translationKeysFor(String languageCode) {
  final file = File('assets/translations/$languageCode.json');
  final decoded = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;

  return _flattenKeys(decoded).toSet();
}

Iterable<String> _flattenKeys(
  Map<String, dynamic> values, [
  String prefix = '',
]) sync* {
  for (final entry in values.entries) {
    final key = prefix.isEmpty ? entry.key : '$prefix.${entry.key}';
    final value = entry.value;

    if (value is Map<String, dynamic>) {
      yield* _flattenKeys(value, key);
    } else {
      yield key;
    }
  }
}
