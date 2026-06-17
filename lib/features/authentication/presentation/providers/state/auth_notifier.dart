import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_standard/features/authentication/presentation/providers/state/auth_state.dart';
import 'package:riverpod_standard/shared/models/user_model.dart';
import '../../../../session/domain/repositories/session_repository.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../domain/repositories/auth_repository.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthenticationRepository authRepository;
  final SessionRepository sessionRepository;
  AuthNotifier({required this.authRepository, required this.sessionRepository})
    : super(const AuthState.initial());

  Future<void> loginUser(String username, String password) async {
    state = const AuthState.loading();
    final response = await authRepository.loginUser(
      user: User(username: username, password: password),
    );

    state = await response.fold((failure) => AuthState.failure(failure), (
      user,
    ) async {
      final hasSavedUser = await sessionRepository.saveUser(user: user);
      if (hasSavedUser) {
        return const AuthState.success();
      }
      return AuthState.failure(CacheFailureException());
    });
  }
}
