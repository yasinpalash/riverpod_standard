import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_standard/core/usecases/usecase.dart';
import 'package:riverpod_standard/features/session/di/session_di.dart';

final userLoginCheckProvider = FutureProvider<bool>((ref) async {
  final result = await ref.watch(hasSessionProvider)(const NoParams());
  return result.fold((_) => false, (hasUser) => hasUser);
});
