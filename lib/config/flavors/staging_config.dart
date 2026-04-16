import '../../core/constants /enums.dart';
import '../app_config.dart';

const AppConfig stagingConfig = AppConfig(
  environment: AppEnvironment.staging,
  appName: 'Riverpod Standard Staging',
  baseUrl: 'https://dummyjson.com',
  enableLogging: true,
);
