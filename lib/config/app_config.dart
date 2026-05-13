import 'app_environment.dart';

class AppConfig {
  const AppConfig({
    required this.environment,
    required this.appName,
    required this.baseUrl,
    required this.enableLogging,
    required this.connectTimeout,
    required this.receiveTimeout,
  });

  final AppEnvironment environment;
  final String appName;
  final String baseUrl;
  final bool enableLogging;
  final Duration connectTimeout;
  final Duration receiveTimeout;

  bool get isDev => environment == AppEnvironment.dev;
  bool get isStaging => environment == AppEnvironment.staging;
  bool get isProd => environment == AppEnvironment.prod;

  void validate() {
    if (appName.trim().isEmpty) {
      throw StateError('appName cannot be empty');
    }

    final uri = Uri.tryParse(baseUrl);
    if (baseUrl.trim().isEmpty ||
        uri == null ||
        !uri.hasScheme ||
        !uri.hasAuthority) {
      throw StateError('Invalid baseUrl: $baseUrl');
    }

    if (connectTimeout <= Duration.zero) {
      throw StateError('connectTimeout must be greater than zero');
    }

    if (receiveTimeout <= Duration.zero) {
      throw StateError('receiveTimeout must be greater than zero');
    }
  }
}

const AppConfig devConfig = AppConfig(
  environment: AppEnvironment.dev,
  appName: 'Riverpod Standard Dev',
  baseUrl: 'https://dummyjson.com',
  enableLogging: true,
  connectTimeout: Duration(seconds: 20),
  receiveTimeout: Duration(seconds: 20),
);

const AppConfig stagingConfig = AppConfig(
  environment: AppEnvironment.staging,
  appName: 'Riverpod Standard Staging',
  baseUrl: 'https://dummyjson-stage.com',
  enableLogging: true,
  connectTimeout: Duration(seconds: 20),
  receiveTimeout: Duration(seconds: 20),
);

const AppConfig prodConfig = AppConfig(
  environment: AppEnvironment.prod,
  appName: 'Riverpod Standard',
  baseUrl: 'https://dummyjson.com',
  enableLogging: false,
  connectTimeout: Duration(seconds: 15),
  receiveTimeout: Duration(seconds: 15),
);
