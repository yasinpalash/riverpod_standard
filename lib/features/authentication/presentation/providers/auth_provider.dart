import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_standard/features/authentication/presentation/providers/state/auth_notifier.dart';
import 'package:riverpod_standard/features/authentication/presentation/providers/state/auth_state.dart';

final authStateNotifierProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);
