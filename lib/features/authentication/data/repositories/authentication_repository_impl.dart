import 'package:riverpod_standard/core/errors/exception_mapper.dart';
import 'package:riverpod_standard/core/typedefs/typedefs.dart';
import 'package:riverpod_standard/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:riverpod_standard/features/authentication/domain/repositories/auth_repository.dart';
import 'package:riverpod_standard/features/session/domain/entities/user.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  const AuthenticationRepositoryImpl(this._dataSource);
  final LoginUserDataSource _dataSource;

  @override
  ResultFuture<User> loginUser({
    required String username,
    required String password,
  }) => ExceptionMapper.guard(() async {
    final model = await _dataSource.loginUser(
      username: username,
      password: password,
    );
    return model.toEntity();
  });
}
