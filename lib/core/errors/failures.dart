import 'package:equatable/equatable.dart';
import 'package:riverpod_standard/core/errors/exceptions.dart';

class Failure extends Equatable {
  final String message;
  final int statusCode;
  final String identifier;

  const Failure({
    required this.message,
    required this.statusCode,
    required this.identifier,
  });

  factory Failure.fromException(AppException exception) {
    return Failure(
      message: exception.message,
      statusCode: exception.statusCode,
      identifier: exception.identifier,
    );
  }

  @override
  List<Object?> get props => [message, statusCode, identifier];
}
