import 'package:flutter/material.dart';

const Locale appFallbackLocale = Locale('en');

const List<Locale> appSupportedLocales = [Locale('en'), Locale('bn')];

bool isSupportedLocale(Locale locale) {
  return appSupportedLocales.any(
    (supportedLocale) => supportedLocale.languageCode == locale.languageCode,
  );
}

Locale resolveSupportedLocale(Locale? locale) {
  if (locale == null) {
    return appFallbackLocale;
  }

  for (final supportedLocale in appSupportedLocales) {
    if (supportedLocale.languageCode == locale.languageCode) {
      return supportedLocale;
    }
  }

  return appFallbackLocale;
}
