import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_standard/core/errors/failures.dart';

part 'auth_state.freezed.dart';

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState.initial() = AuthInitial;
  const factory AuthState.loading() = AuthLoading;
  const factory AuthState.failure(Failure failure) = AuthFailure;
  const factory AuthState.success() = AuthSuccess;
}
