import '../../../shared/data/remote/network_service.dart';
import '../../../shared/domain/models/either.dart';
import '../../../shared/domain/models/user/user_model.dart';
import '../../../shared/exceptions/http_exception.dart';

abstract class LoginUserDataSource {
  Future<Either<AppException, User>> loginUser({required User user});
}

class LoginUserRemoteDataSource implements LoginUserDataSource {
  final NetworkService networkService;
  LoginUserRemoteDataSource(this.networkService);

  @override
  Future<Either<AppException, User>> loginUser({required User user}) async {
    // TODO: implement loginUser
    throw UnimplementedError();
  }
}
