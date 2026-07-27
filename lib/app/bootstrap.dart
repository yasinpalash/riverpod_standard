import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:riverpod_standard/app/app.dart';
import 'package:riverpod_standard/config/app_config.dart';
import 'package:riverpod_standard/core/localization/locale_provider.dart';
import 'package:riverpod_standard/core/localization/supported_locales.dart';
import 'package:riverpod_standard/core/logging/logging.dart';
import 'package:riverpod_standard/core/storage/local_storage_service.dart';
import 'package:riverpod_standard/core/system/system_ui_config.dart';
import 'package:riverpod_standard/shared/providers/app_provider.dart';
import '../config/app_config_provider.dart';
import 'observers.dart';

Future<void> bootstrap(AppConfig config) async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  config.validate();
  AppLogger.info(
    'Starting ${config.appName} in ${config.environment.name} environment',
  );

  SystemUiConfig.apply(
    WidgetsBinding.instance.platformDispatcher.platformBrightness,
  );

  final storageService = SharedPrefsLocalStorageService()..init();
  final initialLocale = await loadInitialLocale(storageService);

  runApp(
    ProviderScope(
      observers: [Observers()],
      overrides: [
        appConfigProvider.overrideWithValue(config),
        storageServiceProvider.overrideWithValue(storageService),
        initialLocaleProvider.overrideWithValue(initialLocale),
      ],
      child: EasyLocalization(
        supportedLocales: appSupportedLocales,
        path: 'assets/translations',
        fallbackLocale: appFallbackLocale,
        startLocale: initialLocale,
        useOnlyLangCode: true,
        saveLocale: false,
        child: const MyApp(),
      ),
    ),
  );
}
