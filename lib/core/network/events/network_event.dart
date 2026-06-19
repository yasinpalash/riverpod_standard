enum NetworkEventType { unauthorized, serverError }

class NetworkEvent {
  const NetworkEvent({
    required this.type,
    required this.message,
    this.statusCode,
    this.endpoint,
  });

  final NetworkEventType type;
  final String message;
  final int? statusCode;
  final String? endpoint;
}
