import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_standard/services/user_cache_service/data/datasource/user_local_data_source.dart';
import 'package:riverpod_standard/core/storage/local_storage_service.dart';
import '../../../../shared/providers/app_provider.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../repositories/user_cache_repository.dart';

final userDatasourceProvider =
    Provider.family<UserDataSource, LocalStorageService>(
      (_, networkService) => UserLocalDatasource(networkService),
    );

final userLocalRepositoryProvider = Provider<UserRepository>((ref) {
  final storageService = ref.watch(storageServiceProvider);

  final datasource = ref.watch(userDatasourceProvider(storageService));

  final repository = UserRepositoryImpl(datasource);
  return repository;
});
