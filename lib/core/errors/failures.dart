import 'package:equatable/equatable.dart';
import 'package:riverpod_standard/core/errors/failure_code.dart';

/// Domain-level failure returned in `Left`. Carries a typed [code]; the text
/// shown to users comes from `Failure.userMessage` (core/errors/failure_messages.dart).
class Failure extends Equatable {
  const Failure({
    required this.code,
    this.statusCode,
    this.serverMessage,
    this.identifier = '',
  });

  final FailureCode code;
  final int? statusCode;

  /// Backend-provided message, when there was one.
  final String? serverMessage;

  /// Diagnostic only; never show to users.
  final String identifier;

  @override
  List<Object?> get props => [code, statusCode, serverMessage, identifier];
}
