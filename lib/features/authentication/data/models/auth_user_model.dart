import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_standard/features/session/domain/entities/user.dart';

part 'auth_user_model.freezed.dart';
part 'auth_user_model.g.dart';

/// Login-response DTO owned by the authentication feature.
@freezed
abstract class AuthUserModel with _$AuthUserModel {
  const AuthUserModel._();

  const factory AuthUserModel({
    @Default(0) int id,
    @Default('') String username,
    @Default('') String email,
    @Default('') String firstName,
    @Default('') String lastName,
    @Default('') String gender,
    @Default('') String image,
    @Default('') String token,
  }) = _AuthUserModel;

  factory AuthUserModel.fromJson(Map<String, dynamic> json) =>
      _$AuthUserModelFromJson(json);

  User toEntity() => User(
    id: id,
    username: username,
    email: email,
    firstName: firstName,
    lastName: lastName,
    gender: gender,
    image: image,
    token: token,
  );
}
