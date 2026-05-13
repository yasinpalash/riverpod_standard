import 'package:riverpod_standard/config/app_config.dart';
import 'package:riverpod_standard/config/app_environment.dart';
import 'package:test/test.dart';

void main() {
  group('flavor config', () {
    test('dev config is valid', () {
      expect(() => devConfig.validate(), returnsNormally);
      expect(devConfig.environment, AppEnvironment.dev);
      expect(devConfig.enableLogging, isTrue);
    });

    test('staging config is valid', () {
      expect(() => stagingConfig.validate(), returnsNormally);
      expect(stagingConfig.environment, AppEnvironment.staging);
      expect(stagingConfig.enableLogging, isTrue);
    });

    test('prod config is valid', () {
      expect(() => prodConfig.validate(), returnsNormally);
      expect(prodConfig.environment, AppEnvironment.prod);
      expect(prodConfig.enableLogging, isFalse);
    });
  });
}
