import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String message;
  final int statusCode;
  final String identifier;

  const Failure({
    required this.message,
    required this.statusCode,
    required this.identifier,
  });

  @override
  List<Object?> get props => [message, statusCode, identifier];
}
