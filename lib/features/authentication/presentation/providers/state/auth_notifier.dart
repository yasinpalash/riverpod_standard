import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_standard/features/authentication/presentation/providers/state/auth_state.dart';
import 'package:riverpod_standard/shared/domain/models/user/user_model.dart';
import '../../../../../services/user_cache_service/domain/repositories/user_cache_repository.dart';
import '../../../domain/repositories/auth_repository.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthenticationRepository authRepository;
  final UserRepository userRepository;
  AuthNotifier({required this.authRepository, required this.userRepository})
    : super(const AuthState.initial());

  Future<void> loginUser(String username, String password) async {
    state = const AuthState.loading();
    final response = await authRepository.loginUser(
      user: User(username: username, password: password),
    );

  }
}
