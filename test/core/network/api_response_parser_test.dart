import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_standard/core/errors/exceptions.dart';
import 'package:riverpod_standard/core/network/api_response_parser.dart';

void main() {
  group('ApiResponseParser', () {
    test('parses raw response data', () {
      final response = Response<dynamic>(
        requestOptions: RequestOptions(path: '/profile'),
        statusCode: 200,
        data: {'name': 'Neo'},
      );

      final result = ApiResponseParser.parse<String>(
        response,
        parser: (json) => json['name'] as String,
      );

      expect(result, 'Neo');
    });

    test('unwraps successful envelope response', () {
      final response = Response<dynamic>(
        requestOptions: RequestOptions(path: '/profile'),
        statusCode: 200,
        data: {
          'success': true,
          'message': 'ok',
          'data': {'name': 'Neo'},
        },
      );

      final result = ApiResponseParser.parse<String>(
        response,
        unwrapEnvelope: true,
        parser: (json) => json['name'] as String,
      );

      expect(result, 'Neo');
    });

    test('throws AppException for failed envelope response', () {
      final response = Response<dynamic>(
        requestOptions: RequestOptions(path: '/profile'),
        statusCode: 200,
        data: {'success': false, 'message': 'Unauthorized'},
      );

      expect(
        () => ApiResponseParser.parse<String>(
          response,
          unwrapEnvelope: true,
          parser: (json) => json as String,
        ),
        throwsA(
          isA<AppException>().having(
            (error) => error.message,
            'message',
            'Unauthorized',
          ),
        ),
      );
    });
  });
}
