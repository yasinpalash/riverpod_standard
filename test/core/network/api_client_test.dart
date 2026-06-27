import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_standard/core/network/api_client.dart';

void main() {
  group('ApiClient', () {
    test('configures Dio base options and default headers', () {
      final dio = Dio();
      final client = ApiClient(
        baseUrl: 'https://example.com',
        enableLogging: false,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 20),
        dio: dio,
      );

      expect(client.dio.options.baseUrl, 'https://example.com');
      expect(client.dio.options.connectTimeout, const Duration(seconds: 10));
      expect(client.dio.options.receiveTimeout, const Duration(seconds: 20));
      expect(
        client.dio.options.headers,
        containsPair('Accept', 'application/json'),
      );
      expect(
        client.dio.options.headers,
        containsPair('Content-Type', 'application/json'),
      );
    });
  });
}
