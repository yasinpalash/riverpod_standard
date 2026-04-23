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
