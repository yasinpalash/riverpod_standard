import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_standard/core/usecases/usecase.dart';
import 'package:riverpod_standard/features/session/di/session_di.dart';
import 'package:riverpod_standard/features/session/domain/entities/user.dart';

final currentUserProvider = FutureProvider<User?>((ref) async {
  final result = await ref.watch(getCurrentUserProvider)(const NoParams());
  return result.fold((_) => null, (user) => user);
});
