import '../config/flavors/dev_config.dart';
import 'bootstrap.dart';

Future<void> main() async {
  await bootstrap(devConfig);
}
