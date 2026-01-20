import 'dart:async';

import 'package:riverpod_standard/shared/data/local/storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService implements StorageService {
  SharedPreferences? sharedPreferences;

  final Completer<SharedPreferences> initCompleter =
      Completer<SharedPreferences>();

  @override
  void init() {
    initCompleter.complete(SharedPreferences.getInstance());
  }

  @override
  bool get hasInitialized => sharedPreferences != null;

  @override
  Future<void> clear() {
    // TODO: implement clear
    throw UnimplementedError();
  }

  @override
  Future<Object?> get(String key) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<bool> has(String key) {
    // TODO: implement has
    throw UnimplementedError();
  }





  @override
  Future<bool> remove(String key) {
    // TODO: implement remove
    throw UnimplementedError();
  }

  @override
  Future<bool> set(String key, String data) {
    // TODO: implement set
    throw UnimplementedError();
  }
}
