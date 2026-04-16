import '../core/constants /enums.dart';

class AppConfig {
  const AppConfig({
    required this.environment,
    required this.appName,
    required this.baseUrl,
    required this.enableLogging,
  });

  final AppEnvironment environment;
  final String appName;
  final String baseUrl;
  final bool enableLogging;

  bool get isDev => environment == AppEnvironment.dev;
  bool get isStaging => environment == AppEnvironment.staging;
  bool get isProd => environment == AppEnvironment.prod;
}

//static String baseUrl = 'https://dummyjson.com';
