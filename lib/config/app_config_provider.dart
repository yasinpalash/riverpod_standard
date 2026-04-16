import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_standard/config/app_config.dart';

final appConfigProvider = Provider<AppConfig>((ref) {
  throw UnimplementedError(
    'appConfigProvider must be overridden in bootstrap.dart',
  );
});
