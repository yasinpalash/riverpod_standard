import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_standard/app/app.dart';
import 'package:riverpod_standard/config/app_config.dart';
import 'package:riverpod_standard/core/logging/logging.dart';
import 'package:riverpod_standard/core/system/system_ui_config.dart';
import '../config/app_config_provider.dart';
import 'observers.dart';

Future<void> bootstrap(AppConfig config) async {
  WidgetsFlutterBinding.ensureInitialized();
  config.validate();
  AppLogger.info(
    'Starting ${config.appName} in ${config.environment.name} environment',
  );

  SystemUiConfig.apply(
    WidgetsBinding.instance.platformDispatcher.platformBrightness,
  );

  runApp(
    ProviderScope(
      observers: [Observers()],
      overrides: [appConfigProvider.overrideWithValue(config)],
      child: const MyApp(),
    ),
  );
}
