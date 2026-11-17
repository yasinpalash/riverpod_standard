import 'package:riverpod_standard/core/constants/api_constants.dart';
import 'package:riverpod_standard/core/network/api_response_parser.dart';
import 'package:riverpod_standard/core/network/api_service.dart';
import 'package:riverpod_standard/core/result/either.dart';
import 'package:riverpod_standard/features/authentication/data/models/auth_user_model.dart';

abstract class LoginUserDataSource {
  /// Throws an [AppException] on failure.
  Future<AuthUserModel> loginUser({
    required String username,
    required String password,
  });
}

class LoginUserRemoteDataSource implements LoginUserDataSource {
  LoginUserRemoteDataSource(this.networkService);
  final ApiService networkService;

  @override
  Future<AuthUserModel> loginUser({
    required String username,
    required String password,
  }) async {
    final user = (await networkService.post(
      ApiConstants.authLogin,
      data: {'username': username, 'password': password},
      parser: (json) => AuthUserModel.fromJson(coerceJsonMap(json)),
    )).getOrThrow();
    networkService.updateHeader({ApiConstants.authorizationHeader: user.token});
    return user;
  }
}
