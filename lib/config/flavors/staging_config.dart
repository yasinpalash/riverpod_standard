import '../app_config.dart';
import '../app_environment.dart';

const AppConfig stagingConfig = AppConfig(
  environment: AppEnvironment.staging,
  appName: 'Riverpod Standard Staging',
  baseUrl: 'https://dummyjson-stage.com',
  enableLogging: true,
  connectTimeout: Duration(seconds: 20),
  receiveTimeout: Duration(seconds: 20),
);
