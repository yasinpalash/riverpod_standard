import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../session/presentation/providers/session_provider.dart';

final userLoginCheckProvider = FutureProvider((ref) async {
  final repo = ref.watch(sessionRepositoryProvider);
  return await repo.hasUser();
});
