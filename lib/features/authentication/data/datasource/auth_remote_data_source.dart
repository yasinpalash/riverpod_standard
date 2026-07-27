import 'package:riverpod_standard/core/logging/logging.dart';
import 'package:riverpod_standard/core/constants/api_constants.dart';
import 'package:riverpod_standard/core/localization/locale_keys.g.dart';
import 'package:riverpod_standard/core/network/api_response_parser.dart';
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
        parser: (json) => User.fromJson(coerceJsonMap(json)),
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (user) {
          networkService.updateHeader({
            ApiConstants.authorizationHeader: user.token,
          });
          return Right(user);
        },
      );
    } catch (e, stackTrace) {
      AppLogger.error(
        LocaleKeys.auth_failed_to_parse_login_response,
        error: e,
        stackTrace: stackTrace,
      );
      return Left(
        AppException(
          message: LocaleKeys.common_unknown_error_occurred,
          statusCode: 1,
          identifier: '${e.toString()}\nLoginUserRemoteDataSource.loginUser',
        ),
      );
    }
  }
}
