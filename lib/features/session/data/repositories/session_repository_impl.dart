import 'package:riverpod_standard/core/errors/exception_mapper.dart';
import 'package:riverpod_standard/core/errors/exceptions.dart';
import 'package:riverpod_standard/core/typedefs/typedefs.dart';
import 'package:riverpod_standard/features/session/data/datasources/session_local_data_source.dart';
import 'package:riverpod_standard/features/session/data/models/user_model.dart';
import 'package:riverpod_standard/features/session/domain/entities/user.dart';
import 'package:riverpod_standard/features/session/domain/repositories/session_repository.dart';

class SessionRepositoryImpl implements SessionRepository {
  const SessionRepositoryImpl(this._dataSource);
  final SessionLocalDataSource _dataSource;

  @override
  ResultFuture<User> fetchUser() =>
      ExceptionMapper.guard(() async => (await _dataSource.fetchUser()).toEntity());

  @override
  ResultFuture<void> saveUser(User user) => ExceptionMapper.guard(() async {
    final saved = await _dataSource.saveUser(UserModel.fromEntity(user));
    if (!saved) throw CacheFailureException();
  });

  @override
  ResultFuture<void> deleteUser() =>
      ExceptionMapper.guard(() async {
        await _dataSource.deleteUser();
      });

  @override
  ResultFuture<bool> hasUser() => ExceptionMapper.guard(_dataSource.hasUser);
}
