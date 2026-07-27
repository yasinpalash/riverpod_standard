import 'package:easy_localization/easy_localization.dart';

const List<String> localizationKeyPrefixes = [
  'app.',
  'auth.',
  'common.',
  'home.',
  'network.',
  'settings.',
];

bool isLocalizationKey(String value) {
  return localizationKeyPrefixes.any(value.startsWith);
}

String translateIfLocalizationKey(String value) {
  return isLocalizationKey(value) ? value.tr() : value;
}
