
import 'config/flavors/prod_config.dart';
import 'main/bootstrap.dart';



Future<void> main() async {
  await bootstrap(prodConfig);
}

