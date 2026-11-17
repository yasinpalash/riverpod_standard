import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_standard/core/usecases/usecase.dart';
import 'package:riverpod_standard/features/session/di/session_di.dart';

/// UI-facing session actions, so other features never touch session
/// use cases or DI directly.
final logoutProvider = Provider<Future<void> Function()>((ref) {
  return () async {
    await ref.read(deleteSessionProvider)(const NoParams());
  };
});
