import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_standard/features/authentication/domain/repositories/auth_repository.dart';
import 'package:riverpod_standard/core/network/api_service.dart';
import '../../../../shared/providers/app_provider.dart';
import '../../data/datasource/auth_remote_data_source.dart';
import '../../data/repositories/authentication_repository_impl.dart';

final authDataSourceProvider = Provider.family<LoginUserDataSource, ApiService>(
  (_, networkService) => LoginUserRemoteDataSource(networkService),
);

final authRepositoryProvider = Provider<AuthenticationRepository>((ref) {
  final ApiService networkService = ref.watch(networkServiceProvider);
  final LoginUserDataSource dataSource = ref.watch(
    authDataSourceProvider(networkService),
  );
  return AuthenticationRepositoryImpl(dataSource);
});
