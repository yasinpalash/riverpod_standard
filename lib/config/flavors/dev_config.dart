import '../app_config.dart';
import '../app_environment.dart';

const AppConfig devConfig = AppConfig(
  environment: AppEnvironment.dev,
  appName: 'Riverpod Standard Dev',
  baseUrl: 'https://dummyjson-dev.com',
  enableLogging: true,
  connectTimeout: Duration(seconds: 20),
  receiveTimeout: Duration(seconds: 20),
);
