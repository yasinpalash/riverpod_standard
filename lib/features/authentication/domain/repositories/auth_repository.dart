import 'package:riverpod_standard/core/typedefs/typedefs.dart';
import 'package:riverpod_standard/features/session/domain/entities/user.dart';

abstract class AuthenticationRepository {
  ResultFuture<User> loginUser({
    required String username,
    required String password,
  });
}
