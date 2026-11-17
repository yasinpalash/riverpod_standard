import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_standard/features/authentication/di/auth_di.dart';
import 'package:riverpod_standard/features/authentication/domain/usecases/login_user.dart';
import 'package:riverpod_standard/features/authentication/presentation/providers/state/auth_state.dart';

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() => const AuthState.initial();

  Future<void> login(String username, String password) async {
    state = const AuthState.loading();
    final result = await ref.read(loginUserProvider)(
      LoginParams(username: username, password: password),
    );
    state = result.fold(AuthState.failure, (_) => const AuthState.success());
  }
}
