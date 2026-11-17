import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Enforces the dependency rule: presentation -> domain <- data.
/// Fails the build if a layer imports something it must not know about.
void main() {
  final imports = <String, List<String>>{};
  for (final entity in Directory('lib').listSync(recursive: true)) {
    if (entity is! File || !entity.path.endsWith('.dart')) continue;
    if (RegExp(r'\.(g|freezed|gr)\.dart$').hasMatch(entity.path)) continue;
    imports[entity.path] =
        entity
            .readAsLinesSync()
            .where((l) => l.startsWith('import '))
            .toList();
  }

  List<String> violations({
    required bool Function(String path) appliesTo,
    required bool Function(String importLine) forbidden,
  }) => [
    for (final e in imports.entries)
      if (appliesTo(e.key))
        for (final line in e.value)
          if (forbidden(line)) '${e.key}: $line',
  ];

  bool inLayer(String path, String layer) =>
      RegExp('lib/features/[^/]+/$layer/').hasMatch(path);

  group('architecture', () {
    test('domain depends on neither data, presentation, di nor frameworks', () {
      final found = violations(
        appliesTo: (p) => inLayer(p, 'domain'),
        forbidden:
            (l) =>
                RegExp(r'/(data|presentation|di)/').hasMatch(l) ||
                l.contains('package:flutter/') ||
                l.contains('flutter_riverpod') ||
                l.contains('package:dio/') ||
                l.contains('shared_preferences') ||
                l.contains('flutter_secure_storage') ||
                l.contains('/core/network/') ||
                l.contains('/core/storage/'),
      );
      expect(found, isEmpty, reason: found.join('\n'));
    });

    test('presentation does not import the data layer', () {
      final found = violations(
        appliesTo: (p) => inLayer(p, 'presentation'),
        forbidden: (l) => RegExp(r'features/[^/]+/data/').hasMatch(l),
      );
      expect(found, isEmpty, reason: found.join('\n'));
    });

    test('data does not import presentation', () {
      final found = violations(
        appliesTo: (p) => inLayer(p, 'data'),
        forbidden: (l) => l.contains('/presentation/'),
      );
      expect(found, isEmpty, reason: found.join('\n'));
    });

    test('core never depends on features (except the router)', () {
      final found = violations(
        appliesTo:
            (p) =>
                p.startsWith('lib/core/') &&
                !p.startsWith('lib/core/routes/'),
        forbidden: (l) => l.contains('features/'),
      );
      expect(found, isEmpty, reason: found.join('\n'));
    });
  });
}
