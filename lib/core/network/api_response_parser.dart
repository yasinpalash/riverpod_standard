import 'package:dio/dio.dart';
import 'package:riverpod_standard/core/errors/exceptions.dart';

typedef JsonParser<T> = T Function(dynamic json);

class ApiResponseParser {
  const ApiResponseParser._();

  static T parse<T>(
    Response<dynamic> response, {
    required JsonParser<T> parser,
    bool unwrapEnvelope = false,
  }) {
    if (!unwrapEnvelope) {
      return parser(response.data);
    }

    final body = coerceJsonMap(response.data);
    final parsed = BaseResponseModel<T>.fromJson(body, dataParser: parser);
    final statusCode = response.statusCode ?? 0;
    final isOkCode = statusCode >= 200 && statusCode < 300;

    if (isOkCode && parsed.success) {
      final data = parsed.data;
      if (data is T) {
        return data;
      }

      throw AppException(
        message: 'Response data is not in the expected format.',
        statusCode: statusCode,
        identifier: 'ApiResponseParser.parse',
      );
    }

    throw AppException(
      message:
          parsed.message.isNotEmpty
              ? parsed.message
              : isOkCode
              ? 'Request failed'
              : 'Server error',
      statusCode: statusCode,
      identifier: 'ApiResponseParser.parse',
    );
  }
}

class BaseResponseModel<T> {
  const BaseResponseModel({
    required this.success,
    required this.message,
    required this.data,
    this.errors,
  });

  final bool success;
  final String message;
  final T? data;
  final dynamic errors;

  factory BaseResponseModel.fromJson(
    Map<String, dynamic> json, {
    required JsonParser<T> dataParser,
  }) {
    final rawSuccess = json['success'] ?? json['status'];
    final success =
        rawSuccess == true ||
        rawSuccess == 1 ||
        rawSuccess == '1' ||
        rawSuccess.toString().toLowerCase() == 'true';

    return BaseResponseModel<T>(
      success: success,
      message: (json['message'] ?? '').toString(),
      data: json.containsKey('data') ? dataParser(json['data']) : null,
      errors: json['errors'] ?? json['error'],
    );
  }
}

Map<String, dynamic> coerceJsonMap(dynamic raw) {
  if (raw == null) return {};
  if (raw is Map<String, dynamic>) return raw;
  if (raw is Map) return Map<String, dynamic>.from(raw);
  return {};
}

abstract final class DioExtras {
  static const requestId = 'network_request_id';
  static const startTimeMs = 'network_start_time_ms';
  static const retryCount = 'retry_count';
  static const skipErrorLog = 'network_skip_error_log';
  static const disableRetry = 'network_disable_retry';
}
