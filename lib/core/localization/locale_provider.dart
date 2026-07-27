import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_standard/core/constants/storage_keys.dart';
import 'package:riverpod_standard/core/localization/supported_locales.dart';
import 'package:riverpod_standard/core/storage/local_storage_service.dart';
import 'package:riverpod_standard/shared/providers/app_provider.dart';

final initialLocaleProvider = Provider<Locale>((_) => appFallbackLocale);

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  final storageService = ref.watch(storageServiceProvider);
  final initialLocale = ref.watch(initialLocaleProvider);
  return LocaleNotifier(storageService, initialLocale);
});

class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier(this._storageService, Locale initialLocale)
    : super(resolveSupportedLocale(initialLocale));

  final LocalStorageService _storageService;

  Future<void> setLocale(Locale locale) async {
    final resolvedLocale = resolveSupportedLocale(locale);
    state = resolvedLocale;
    await _storageService.set(
      StorageKeys.currentLocale,
      resolvedLocale.languageCode,
    );
  }
}

Future<Locale> loadInitialLocale(LocalStorageService storageService) async {
  try {
    final savedLocaleCode = await storageService.get(StorageKeys.currentLocale);
    final savedLocale =
        savedLocaleCode is String && savedLocaleCode.isNotEmpty
            ? Locale(savedLocaleCode)
            : null;

    return resolveSupportedLocale(savedLocale ?? _deviceLocale);
  } catch (_) {
    return appFallbackLocale;
  }
}

Locale get _deviceLocale {
  return WidgetsBinding.instance.platformDispatcher.locale;
}
