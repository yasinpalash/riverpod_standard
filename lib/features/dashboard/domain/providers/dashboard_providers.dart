import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/data/remote/network_service.dart';
import '../../../../shared/domain/providers/dio_network_service_provider.dart';
import '../../data/datasource/dashboard_remote_datasource.dart';
import '../../data/repositories/dashboard_repository_impl.dart';
import '../repositories/dashboard_repository.dart';

final dashboardDatasourceProvider =
    Provider.family<DashboardDatasource, NetworkService>(
      (_, networkService) => DashboardRemoteDatasource(networkService),
    );
final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  final networkService = ref.watch(networkServiceProvider);
  final datasource = ref.watch(dashboardDatasourceProvider(networkService));
  final repository = DashboardRepositoryImpl(datasource);

  return repository;
});
