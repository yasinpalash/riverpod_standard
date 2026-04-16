import '../app_config.dart';
import '../app_environment.dart';

const AppConfig prodConfig = AppConfig(
  environment: AppEnvironment.prod,
  appName: 'Riverpod Standard',
  baseUrl: 'https://dummyjson.com',
  enableLogging: false,
);
