import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/data/remote/network_service.dart';
import '../../../../shared/domain/providers/dio_network_service_provider.dart';
import '../../data/datasource/home_remote_datasource.dart';
import '../../data/repositories/home_repository_impl.dart';
import '../repositories/home_repository.dart';

final homeDatasourceProvider = Provider.family<HomeDatasource, NetworkService>(
  (_, networkService) => HomeRemoteDatasource(networkService),
);
final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  final networkService = ref.watch(networkServiceProvider);
  final datasource = ref.watch(homeDatasourceProvider(networkService));
  final repository = HomeRepositoryImpl(datasource);

  return repository;
});
