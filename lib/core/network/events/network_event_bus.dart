import 'dart:async';

import 'package:riverpod_standard/core/network/events/network_event.dart';

class NetworkEventBus {
  final StreamController<NetworkEvent> _controller =
      StreamController<NetworkEvent>.broadcast();

  Stream<NetworkEvent> get stream => _controller.stream;

  void publish(NetworkEvent event) {
    if (!_controller.isClosed) {
      _controller.add(event);
    }
  }

  void dispose() {
    _controller.close();
  }
}
