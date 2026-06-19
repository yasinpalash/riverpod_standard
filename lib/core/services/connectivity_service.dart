import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  ConnectivityService({Connectivity? connectivity})
    : _connectivity = connectivity ?? Connectivity();

  final Connectivity _connectivity;

  Future<bool> get hasConnection async {
    final result = await _connectivity.checkConnectivity();
    return _hasNetwork(result);
  }

  Stream<bool> get onConnectivityChanged async* {
    yield await hasConnection;
    yield* _connectivity.onConnectivityChanged.map(_hasNetwork).distinct();
  }

  bool _hasNetwork(ConnectivityResult result) =>
      result != ConnectivityResult.none;
}
