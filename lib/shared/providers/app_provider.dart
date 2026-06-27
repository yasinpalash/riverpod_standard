import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_standard/config/app_config_provider.dart';
import 'package:riverpod_standard/core/monitoring/error_reporter.dart';
import 'package:riverpod_standard/core/network/api_client.dart';
import 'package:riverpod_standard/core/network/events/network_event_bus.dart';
import 'package:riverpod_standard/core/network/api_service.dart';
import 'package:riverpod_standard/core/services/connectivity_service.dart';
import 'package:riverpod_standard/core/services/haptic_service.dart';
import 'package:riverpod_standard/core/services/micro_interaction_service.dart';
import 'package:riverpod_standard/core/storage/local_storage_service.dart';

final connectivityServiceProvider = Provider<ConnectivityService>(
  (ref) => ConnectivityService(),
);

final connectivityStatusProvider = StreamProvider<bool>((ref) {
  final connectivityService = ref.watch(connectivityServiceProvider);
  return connectivityService.onConnectivityChanged;
});

final networkEventBusProvider = Provider<NetworkEventBus>((ref) {
  final eventBus = NetworkEventBus();
  ref.onDispose(eventBus.dispose);
  return eventBus;
});

final networkEventProvider = StreamProvider((ref) {
  final eventBus = ref.watch(networkEventBusProvider);
  return eventBus.stream;
});

final errorReporterProvider = Provider<ErrorReporter>(
  (ref) => const NoopErrorReporter(),
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
  final connectivityService = ref.watch(connectivityServiceProvider);
  final storageService = ref.watch(storageServiceProvider);
  final networkEventBus = ref.watch(networkEventBusProvider);
  final errorReporter = ref.watch(errorReporterProvider);

  return ApiClient(
    baseUrl: appConfig.baseUrl,
    enableLogging: appConfig.enableLogging,
    connectTimeout: appConfig.connectTimeout,
    receiveTimeout: appConfig.receiveTimeout,
    connectivityService: connectivityService,
    storageService: storageService,
    networkEventBus: networkEventBus,
    errorReporter: errorReporter,
  );
});

final networkServiceProvider = apiServiceProvider;
