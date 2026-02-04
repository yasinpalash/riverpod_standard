import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_standard/features/authentication/domain/repositories/auth_repository.dart';
import 'package:riverpod_standard/shared/data/remote/network_service.dart';
import '../../../../shared/domain/providers/dio_network_service_provider.dart';
import '../../data/datasource/auth_remote_data_source.dart';
import '../../data/repositories/authentication_repository_impl.dart';

final authDataSourceProvider =
    Provider.family<LoginUserDataSource, NetworkService>(
      (_, networkService) => LoginUserRemoteDataSource(networkService),
    );

final authRepositoryProvider = Provider<AuthenticationRepository>((ref) {
  final NetworkService networkService = ref.watch(networkServiceProvider);
  final LoginUserDataSource dataSource =
  ref.watch(authDataSourceProvider(networkService));
  return AuthenticationRepositoryImpl(dataSource);
});
