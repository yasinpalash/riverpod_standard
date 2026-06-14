import 'package:riverpod_standard/features/authentication/domain/repositories/auth_repository.dart';
import 'package:riverpod_standard/shared/models/either.dart';
import 'package:riverpod_standard/shared/models/user_model.dart';
import 'package:riverpod_standard/core/errors/exceptions.dart';
import '../datasource/auth_remote_data_source.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final LoginUserDataSource dataSource;

  AuthenticationRepositoryImpl(this.dataSource);

  @override
  Future<Either<AppException, User>> loginUser({required User user}) {
    return dataSource.loginUser(user: user);
  }
}
