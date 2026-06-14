import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStorageService {
  void init();

  bool get hasInitialized;

  Future<bool> remove(String key);

  Future<Object?> get(String key);

  Future<bool> set(String key, String data);

  Future<void> clear();

  Future<bool> has(String key);
}

class SharedPrefsLocalStorageService implements LocalStorageService {
  SharedPreferences? sharedPreferences;

  final Completer<SharedPreferences> initCompleter =
      Completer<SharedPreferences>();

  @override
  void init() {
    if (!initCompleter.isCompleted) {
      initCompleter.complete(SharedPreferences.getInstance());
    }
  }

  @override
  bool get hasInitialized => sharedPreferences != null;

  @override
  Future<void> clear() async {
    sharedPreferences = await initCompleter.future;
    await sharedPreferences!.clear();
  }

  @override
  Future<Object?> get(String key) async {
    sharedPreferences = await initCompleter.future;
    return sharedPreferences!.get(key);
  }

  @override
  Future<bool> has(String key) async {
    sharedPreferences = await initCompleter.future;
    return sharedPreferences?.containsKey(key) ?? false;
  }

  @override
  Future<bool> remove(String key) async {
    sharedPreferences = await initCompleter.future;
    return sharedPreferences!.remove(key);
  }

  @override
  Future<bool> set(String key, String data) async {
    sharedPreferences = await initCompleter.future;
    return sharedPreferences!.setString(key, data);
  }
}
