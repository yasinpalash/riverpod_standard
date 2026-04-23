enum AppEnvironment { dev, staging, prod }

extension AppEnvironmentX on AppEnvironment {
  String get name {
    switch (this) {
      case AppEnvironment.dev:
        return 'dev';

      case AppEnvironment.staging:
        return 'staging';

      case AppEnvironment.prod:
        return 'prod';
    }
  }

  bool get isDev => this == AppEnvironment.dev;
  bool get isStaging => this == AppEnvironment.staging;
  bool get isProd => this == AppEnvironment.prod;
}
