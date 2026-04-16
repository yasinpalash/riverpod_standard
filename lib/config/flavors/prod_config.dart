import '../../core/constants /enums.dart';
import '../app_config.dart';

const AppConfig prodConfig = AppConfig(
  environment: AppEnvironment.prod,
  appName: 'Riverpod Standard',
  baseUrl: 'https://dummyjson.com',
  enableLogging: false,
);
