import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_standard/features/authentication/presentation/providers/state/auth_notifier.dart';
import 'package:riverpod_standard/features/authentication/presentation/providers/state/auth_state.dart';
import '../../../session/domain/repositories/session_repository.dart';
import '../../../session/presentation/providers/session_provider.dart';
import '../../domain/providers/login_provider.dart';
import '../../domain/repositories/auth_repository.dart';

final authStateNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
      final AuthenticationRepository authenticationRepository = ref.watch(
        authRepositoryProvider,
      );
      final SessionRepository sessionRepository = ref.watch(
        sessionRepositoryProvider,
      );
      return AuthNotifier(
        authRepository: authenticationRepository,
        sessionRepository: sessionRepository,
      );
    });
