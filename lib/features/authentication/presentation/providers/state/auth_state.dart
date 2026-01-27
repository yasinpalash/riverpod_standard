import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../../shared/exceptions/http_exception.dart';

part 'auth_state.freezed.dart';
@freezed
abstract class AuthState with _$AuthState{
  const factory AuthState.initial() = Initial;
  const factory AuthState.loading() = Loading;
  const factory AuthState.failure(AppException exception) = Failure;
  const factory AuthState.success() = Success;
}