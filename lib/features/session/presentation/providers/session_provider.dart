import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_standard/core/storage/local_storage_service.dart';
import 'package:riverpod_standard/features/session/data/datasources/session_local_data_source.dart';
import '../../../../shared/providers/app_provider.dart';
import '../../data/repositories/session_repository_impl.dart';
import '../../domain/repositories/session_repository.dart';

final sessionLocalDataSourceProvider =
    Provider.family<SessionLocalDataSource, LocalStorageService>(
      (_, storageService) => SessionLocalDataSourceImpl(storageService),
    );

final sessionRepositoryProvider = Provider<SessionRepository>((ref) {
  final storageService = ref.watch(storageServiceProvider);

  final dataSource = ref.watch(sessionLocalDataSourceProvider(storageService));

  final repository = SessionRepositoryImpl(dataSource);
  return repository;
});
