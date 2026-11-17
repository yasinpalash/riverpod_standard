import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:riverpod_standard/core/constants/api_constants.dart';
import 'package:riverpod_standard/core/constants/storage_keys.dart';
import 'package:riverpod_standard/core/storage/secure_storage_service.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._storageService);

  final SecureStorageService _storageService;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _readToken();

    if (token != null && token.isNotEmpty) {
      options.headers[ApiConstants.authorizationHeader] = _formatBearerToken(
        token,
      );
    }

    handler.next(options);
  }

  Future<String?> _readToken() async {
    final accessToken = await _storageService.read(StorageKeys.accessToken);
    if (accessToken != null && accessToken.isNotEmpty) {
      return accessToken;
    }

    final userJson = await _storageService.read(StorageKeys.user);
    if (userJson == null || userJson.isEmpty) {
      return null;
    }

    try {
      final decoded = jsonDecode(userJson);
      if (decoded is Map<String, dynamic>) {
        final token = decoded['token'];
        if (token is String && token.isNotEmpty) {
          return token;
        }
      }
    } catch (_) {
      return null;
    }

    return null;
  }

  String _formatBearerToken(String token) {
    if (token.toLowerCase().startsWith('bearer ')) {
      return token;
    }

    return 'Bearer $token';
  }
}
