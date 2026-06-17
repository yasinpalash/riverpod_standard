import 'dart:io';

class AppConstants {
  AppConstants._();

  static final bool isTestMode = Platform.environment.containsKey(
    'FLUTTER_TEST',
  );
}
