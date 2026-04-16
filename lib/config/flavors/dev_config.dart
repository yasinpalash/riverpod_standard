import 'package:riverpod_standard/config/app_config.dart';
import 'package:riverpod_standard/config/app_environment.dart';

const AppConfig devConfig = AppConfig(
  environment: AppEnvironment.dev,
  appName: 'Riverpod Standard Dev',
  baseUrl: 'https://dummyjson.com',
  enableLogging: true,
);
