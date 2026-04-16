import '../app_config.dart';
import '../app_environment.dart';

const AppConfig stagingConfig = AppConfig(
  environment: AppEnvironment.staging,
  appName: 'Riverpod Standard Staging',
  baseUrl: 'https://dummyjson.com',
  enableLogging: true,
);
