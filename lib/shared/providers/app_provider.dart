import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_standard/config/app_config_provider.dart';
import 'package:riverpod_standard/core/network/api_client.dart';
import 'package:riverpod_standard/core/network/api_service.dart';
import 'package:riverpod_standard/core/services/connectivity_service.dart';
import 'package:riverpod_standard/core/services/haptic_service.dart';
import 'package:riverpod_standard/core/services/micro_interaction_service.dart';
import 'package:riverpod_standard/core/storage/local_storage_service.dart';

final connectivityServiceProvider = Provider<ConnectivityService>(
  (ref) => ConnectivityService(),
);

final hapticServiceProvider = Provider<HapticService>(
  (ref) => const HapticService(),
);

final microInteractionServiceProvider = Provider<MicroInteractionService>((
  ref,
) {
  final hapticService = ref.watch(hapticServiceProvider);
  return MicroInteractionService(hapticService);
});

final storageServiceProvider = Provider<LocalStorageService>((ref) {
  final prefsService = SharedPrefsLocalStorageService();
  prefsService.init();
  return prefsService;
});

final apiServiceProvider = Provider<ApiService>((ref) {
  final appConfig = ref.watch(appConfigProvider);
  final dio = Dio();

  return ApiClient(
    dio,
    baseUrl: appConfig.baseUrl,
    enableLogging: appConfig.enableLogging,
    connectTimeout: appConfig.connectTimeout,
    receiveTimeout: appConfig.receiveTimeout,
  );
});

final networkServiceProvider = apiServiceProvider;
