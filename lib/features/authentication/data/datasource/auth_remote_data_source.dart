import 'package:riverpod_standard/core/logging/logging.dart';
import 'package:riverpod_standard/core/constants/api_constants.dart';
import 'package:riverpod_standard/core/constants/app_strings.dart';
import '../../../../core/network/api_service.dart';
import '../../../../shared/models/either.dart';
import '../../../../shared/models/user_model.dart';
import '../../../../core/errors/exceptions.dart';

abstract class LoginUserDataSource {
  Future<Either<AppException, User>> loginUser({required User user});
}

class LoginUserRemoteDataSource implements LoginUserDataSource {
  final ApiService networkService;
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
        AppStrings.failedToParseLoginResponse,
        error: e,
        stackTrace: stackTrace,
      );
      return Left(
        AppException(
          message: AppStrings.unknownErrorOccurred,
          statusCode: 1,
          identifier: '${e.toString()}\nLoginUserRemoteDataSource.loginUser',
        ),
      );
    }
  }
}
