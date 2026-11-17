import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_standard/features/session/data/datasources/session_local_data_source.dart';
import 'package:riverpod_standard/features/session/data/repositories/session_repository_impl.dart';
import 'package:riverpod_standard/features/session/domain/repositories/session_repository.dart';
import 'package:riverpod_standard/features/session/domain/usecases/session_usecases.dart';
import 'package:riverpod_standard/shared/providers/app_provider.dart';

// Composition root for the session feature: the only place that wires
// data-layer implementations to domain contracts.
final sessionLocalDataSourceProvider = Provider<SessionLocalDataSource>(
  (ref) => SessionLocalDataSourceImpl(ref.watch(secureStorageProvider)),
);

final sessionRepositoryProvider = Provider<SessionRepository>(
  (ref) => SessionRepositoryImpl(ref.watch(sessionLocalDataSourceProvider)),
);

final getCurrentUserProvider = Provider(
  (ref) => GetCurrentUser(ref.watch(sessionRepositoryProvider)),
);
final saveUserProvider = Provider(
  (ref) => SaveUser(ref.watch(sessionRepositoryProvider)),
);
final deleteSessionProvider = Provider(
  (ref) => DeleteSession(ref.watch(sessionRepositoryProvider)),
);
final hasSessionProvider = Provider(
  (ref) => HasSession(ref.watch(sessionRepositoryProvider)),
);
