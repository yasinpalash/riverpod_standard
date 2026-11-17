import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_standard/features/home/presentation/providers/state/home_notifier.dart';
import 'package:riverpod_standard/features/home/presentation/providers/state/home_state.dart';

final homeNotifierProvider = NotifierProvider<HomeNotifier, HomeState>(
  HomeNotifier.new,
);
