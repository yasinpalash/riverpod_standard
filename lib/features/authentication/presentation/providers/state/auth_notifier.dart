import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_standard/features/authentication/presentation/providers/state/auth_state.dart';
import '../../../../../services/user_cache_service/domain/repositories/user_cache_repository.dart';
import '../../../domain/repositories/auth_repository.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthenticationRepository authRepository;
  final UserRepository userRepository;
  AuthNotifier({required this.authRepository, required this.userRepository})
    : super(const AuthState.initial());
}
