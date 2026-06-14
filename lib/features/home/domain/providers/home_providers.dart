import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/api_service.dart';
import '../../../../shared/providers/app_provider.dart';
import '../../data/datasource/home_remote_datasource.dart';
import '../../data/repositories/home_repository_impl.dart';
import '../repositories/home_repository.dart';

final homeDatasourceProvider = Provider.family<HomeDatasource, ApiService>(
  (_, networkService) => HomeRemoteDatasource(networkService),
);
final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  final networkService = ref.watch(networkServiceProvider);
  final datasource = ref.watch(homeDatasourceProvider(networkService));
  final repository = HomeRepositoryImpl(datasource);

  return repository;
});
