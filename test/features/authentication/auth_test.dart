import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod_standard/core/errors/failures.dart';
import 'package:riverpod_standard/core/result/either.dart';
import 'package:riverpod_standard/features/authentication/di/auth_di.dart';
import 'package:riverpod_standard/features/authentication/domain/repositories/auth_repository.dart';
import 'package:riverpod_standard/features/authentication/presentation/providers/auth_provider.dart';
import 'package:riverpod_standard/features/authentication/presentation/providers/state/auth_state.dart';
import 'package:riverpod_standard/features/session/di/session_di.dart';
import 'package:riverpod_standard/features/session/domain/entities/user.dart';
import 'package:riverpod_standard/features/session/domain/repositories/session_repository.dart';

class _MockAuthRepository extends Mock implements AuthenticationRepository {}

class _MockSessionRepository extends Mock implements SessionRepository {}

void main() {
  setUpAll(() => registerFallbackValue(const User()));

  const user = User(id: 1, username: 'emily', token: 'abc');
  const failure = Failure(message: 'bad', statusCode: 401, identifier: 'auth');

  late _MockAuthRepository auth;
  late _MockSessionRepository session;
  late ProviderContainer container;

  setUp(() {
    auth = _MockAuthRepository();
    session = _MockSessionRepository();
    container = ProviderContainer(
      overrides: [
        authRepositoryProvider.overrideWithValue(auth),
        sessionRepositoryProvider.overrideWithValue(session),
      ],
    );
    addTearDown(container.dispose);
  });

  Future<void> login() => container
      .read(authStateNotifierProvider.notifier)
      .login('emily', 'pw');

  test('succeeds and saves the user', () async {
    when(
      () => auth.loginUser(username: 'emily', password: 'pw'),
    ).thenAnswer((_) async => const Right(user));
    when(() => session.saveUser(user)).thenAnswer((_) async => const Right(null));

    await login();

    expect(container.read(authStateNotifierProvider), const AuthState.success());
    verify(() => session.saveUser(user)).called(1);
  });

  test('fails with the login failure and does not save', () async {
    when(
      () => auth.loginUser(username: 'emily', password: 'pw'),
    ).thenAnswer((_) async => const Left(failure));

    await login();

    expect(
      container.read(authStateNotifierProvider),
      const AuthState.failure(failure),
    );
    verifyNever(() => session.saveUser(any()));
  });

  test('fails when the session cannot be saved', () async {
    when(
      () => auth.loginUser(username: 'emily', password: 'pw'),
    ).thenAnswer((_) async => const Right(user));
    when(() => session.saveUser(user)).thenAnswer((_) async => const Left(failure));

    await login();

    expect(container.read(authStateNotifierProvider), isA<AuthFailure>());
  });
}
