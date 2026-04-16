import '../config/flavors/staging_config.dart';
import 'bootstrap.dart';

Future<void> main() async {
  await bootstrap(stagingConfig);
}
