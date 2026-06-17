import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_standard/features/session/presentation/providers/session_provider.dart';
import '../../../../shared/models/user_model.dart';

final currentUserProvider = FutureProvider<User?>((ref) async {
  final repository = ref.watch(sessionRepositoryProvider);
  final eitherType = (await repository.fetchUser());
  return eitherType.fold((l) => null, (r) => r);
});
