import 'package:equatable/equatable.dart';
import 'package:riverpod_standard/core/result/either.dart';
import 'package:riverpod_standard/core/typedefs/typedefs.dart';
import 'package:riverpod_standard/core/usecases/usecase.dart';
import 'package:riverpod_standard/features/authentication/domain/repositories/auth_repository.dart';
import 'package:riverpod_standard/features/session/domain/entities/user.dart';
import 'package:riverpod_standard/features/session/domain/repositories/session_repository.dart';

class LoginParams extends Equatable {
  const LoginParams({required this.username, required this.password});
  final String username;
  final String password;

  @override
  List<Object?> get props => [username, password];
}

/// Authenticates the user and starts a session by persisting the user.
class LoginUser extends UseCase<User, LoginParams> {
  const LoginUser(this._auth, this._session);
  final AuthenticationRepository _auth;
  final SessionRepository _session;

  @override
  ResultFuture<User> call(LoginParams params) async {
    final login = await _auth.loginUser(
      username: params.username,
      password: params.password,
    );
    return login.fold(
      (failure) async => Left(failure),
      (user) async => (await _session.saveUser(user)).map((_) => user),
    );
  }
}
