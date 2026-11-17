import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_standard/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:riverpod_standard/features/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:riverpod_standard/features/authentication/domain/repositories/auth_repository.dart';
import 'package:riverpod_standard/features/authentication/domain/usecases/login_user.dart';
import 'package:riverpod_standard/features/session/di/session_di.dart';
import 'package:riverpod_standard/shared/providers/app_provider.dart';

// Composition root for the authentication feature.
final authDataSourceProvider = Provider<LoginUserDataSource>(
  (ref) => LoginUserRemoteDataSource(ref.watch(networkServiceProvider)),
);

final authRepositoryProvider = Provider<AuthenticationRepository>(
  (ref) => AuthenticationRepositoryImpl(ref.watch(authDataSourceProvider)),
);

final loginUserProvider = Provider(
  (ref) => LoginUser(
    ref.watch(authRepositoryProvider),
    ref.watch(sessionRepositoryProvider),
  ),
);
