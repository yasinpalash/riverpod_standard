import '../app/bootstrap.dart';
import '../config/app_config.dart';

Future<void> main() async {
  await bootstrap(stagingConfig);
}
