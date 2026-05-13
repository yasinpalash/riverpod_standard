import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_standard/features/home/presentation/providers/state/home_notifier.dart';
import 'package:riverpod_standard/features/home/presentation/providers/state/home_state.dart';
import '../../domain/providers/home_providers.dart';

final homeNotifierProvider = StateNotifierProvider<HomeNotifier, HomeState>((
  ref,
) {
  final repository = ref.watch(homeRepositoryProvider);
  return HomeNotifier(repository)..fetchProducts();
});
