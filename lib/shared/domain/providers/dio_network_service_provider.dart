import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/app_config_provider.dart';
import '../../data/remote/dio_network_service.dart';

final networkServiceProvider = Provider<DioNetworkService>((ref) {
  final appConfig = ref.watch(appConfigProvider);
  final dio = Dio();

  return DioNetworkService(
    dio,
    baseUrl: appConfig.baseUrl,
    enableLogging: appConfig.enableLogging,
    connectTimeout: appConfig.connectTimeout,
    receiveTimeout: appConfig.receiveTimeout,
  );
});
