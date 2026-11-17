import 'package:riverpod_standard/core/typedefs/typedefs.dart';
import 'package:riverpod_standard/features/session/domain/entities/user.dart';

abstract class SessionRepository {
  ResultFuture<User> fetchUser();
  ResultFuture<void> saveUser(User user);
  ResultFuture<void> deleteUser();
  ResultFuture<bool> hasUser();
}
