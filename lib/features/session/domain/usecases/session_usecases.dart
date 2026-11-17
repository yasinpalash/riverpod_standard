import 'package:riverpod_standard/core/typedefs/typedefs.dart';
import 'package:riverpod_standard/core/usecases/usecase.dart';
import 'package:riverpod_standard/features/session/domain/entities/user.dart';
import 'package:riverpod_standard/features/session/domain/repositories/session_repository.dart';

class GetCurrentUser extends UseCase<User, NoParams> {
  const GetCurrentUser(this._repository);
  final SessionRepository _repository;

  @override
  ResultFuture<User> call(NoParams params) => _repository.fetchUser();
}

class SaveUser extends UseCase<void, User> {
  const SaveUser(this._repository);
  final SessionRepository _repository;

  @override
  ResultFuture<void> call(User params) => _repository.saveUser(params);
}

class DeleteSession extends UseCase<void, NoParams> {
  const DeleteSession(this._repository);
  final SessionRepository _repository;

  @override
  ResultFuture<void> call(NoParams params) => _repository.deleteUser();
}

class HasSession extends UseCase<bool, NoParams> {
  const HasSession(this._repository);
  final SessionRepository _repository;

  @override
  ResultFuture<bool> call(NoParams params) => _repository.hasUser();
}
