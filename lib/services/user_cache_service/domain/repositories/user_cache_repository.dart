import '../../../../shared/domain/models/either.dart';
import '../../../../shared/models/user_model.dart';
import '../../../../core/errors/exceptions.dart';

abstract class UserRepository {
  Future<Either<AppException, User>> fetchUser();
  Future<bool> saveUser({required User user});
  Future<bool> deleteUser();
  Future<bool> hasUser();
}
