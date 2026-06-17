import 'package:riverpod_standard/core/errors/exceptions.dart';
import 'package:riverpod_standard/features/session/domain/repositories/session_repository.dart';
import 'package:riverpod_standard/shared/models/either.dart';
import 'package:riverpod_standard/shared/models/user_model.dart';
import '../datasources/session_local_data_source.dart';

class SessionRepositoryImpl extends SessionRepository {
  SessionRepositoryImpl(this.dataSource);

  final SessionLocalDataSource dataSource;

  @override
  Future<bool> deleteUser() {
    return dataSource.deleteUser();
  }

  @override
  Future<Either<AppException, User>> fetchUser() {
    return dataSource.fetchUser();
  }

  @override
  Future<bool> hasUser() {
    return dataSource.hasUser();
  }

  @override
  Future<bool> saveUser({required User user}) {
    return dataSource.saveUser(user: user);
  }
}
