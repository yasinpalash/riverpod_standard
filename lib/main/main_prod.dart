import '../config/flavors/prod_config.dart';
import 'bootstrap.dart';

Future<void> main() async {
  await bootstrap(prodConfig);
}
