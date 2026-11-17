import 'dart:convert';
import 'package:riverpod_standard/core/constants/storage_keys.dart';
import 'package:riverpod_standard/core/errors/exceptions.dart';
import 'package:riverpod_standard/core/storage/secure_storage_service.dart';
import 'package:riverpod_standard/features/session/data/models/user_model.dart';

abstract class SessionLocalDataSource {
  String get storageKey;

  /// Throws [AppException] when no user is stored.
  Future<UserModel> fetchUser();
  Future<bool> saveUser(UserModel user);
  Future<bool> deleteUser();
  Future<bool> hasUser();
}

class SessionLocalDataSourceImpl extends SessionLocalDataSource {
  SessionLocalDataSourceImpl(this.storageService);
  final SecureStorageService storageService;

  @override
  String get storageKey => StorageKeys.user;

  @override
  Future<UserModel> fetchUser() async {
    final data = await storageService.read(storageKey);
    if (data == null) {
      throw AppException(
        identifier: 'SessionLocalDataSourceImpl',
        statusCode: 404,
        message: 'User not found',
      );
    }
    return UserModel.fromJson(jsonDecode(data) as Map<String, dynamic>);
  }

  @override
  Future<bool> deleteUser() async {
    await storageService.delete(storageKey);
    return true;
  }

  @override
  Future<bool> hasUser() async => await storageService.read(storageKey) != null;

  @override
  Future<bool> saveUser(UserModel user) async {
    await storageService.write(
      key: storageKey,
      value: jsonEncode(user.toJson()),
    );
    return true;
  }
}
