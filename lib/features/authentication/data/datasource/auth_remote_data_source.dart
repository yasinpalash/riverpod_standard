import 'package:riverpod_standard/core/logging/logging.dart';
import 'package:riverpod_standard/core/constants/api_constants.dart';
import '../../../../shared/data/remote/network_service.dart';
import '../../../../shared/domain/models/either.dart';
import '../../../../shared/domain/models/user/user_model.dart';
import '../../../../shared/exceptions/http_exception.dart';

abstract class LoginUserDataSource {
  Future<Either<AppException, User>> loginUser({required User user});
}

class LoginUserRemoteDataSource implements LoginUserDataSource {
  final NetworkService networkService;
  LoginUserRemoteDataSource(this.networkService);

  @override
  Future<Either<AppException, User>> loginUser({required User user}) async {
    try {
      final eitherType = await networkService.post(
        ApiConstants.authLogin,
        data: user.toJson(),
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          final user = User.fromJson(response.data);
          networkService.updateHeader({
            ApiConstants.authorizationHeader: user.token,
          });
          return Right(user);
        },
      );
    } catch (e, stackTrace) {
      AppLogger.error(
        'Failed to parse login response',
        error: e,
        stackTrace: stackTrace,
      );
      return Left(
        AppException(
          message: 'Unknown error occurred',
          statusCode: 1,
          identifier: '${e.toString()}\nLoginUserRemoteDataSource.loginUser',
        ),
      );
    }
  }
}
