import 'package:riverpod_standard/shared/models/either.dart';
import 'package:riverpod_standard/shared/models/user_model.dart';
import 'package:riverpod_standard/core/errors/exceptions.dart';

abstract class AuthenticationRepository {
  Future<Either<AppException, User>> loginUser({required User user});
}
