# riverpod_standard

A new Flutter project.

## Localization

Translations live in:

```text
assets/translations/en.json
assets/translations/bn.json
```

The app uses EasyLocalization for runtime translation loading and generated
`LocaleKeys` for safer key usage in Dart code.

After adding, removing, or renaming translation keys, regenerate keys:

```bash
dart run easy_localization:generate -S assets/translations -O lib/core/localization -o locale_keys.g.dart -f keys
```

Then verify:

```bash
flutter analyze
flutter test
```

Keep all locale files in sync. The test suite checks that every supported
locale has a translation file and that all translation files expose the same
keys.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
