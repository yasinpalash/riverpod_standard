import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_standard/features/session/domain/entities/user.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

/// Data-layer representation of [User] (JSON / storage).
@freezed
abstract class UserModel with _$UserModel {
  const UserModel._();

  const factory UserModel({
    @Default(0) int id,
    @Default('') String username,
    @Default('') String email,
    @Default('') String firstName,
    @Default('') String lastName,
    @Default('') String gender,
    @Default('') String image,
    @Default('') String token,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  factory UserModel.fromEntity(User user) => UserModel(
    id: user.id,
    username: user.username,
    email: user.email,
    firstName: user.firstName,
    lastName: user.lastName,
    gender: user.gender,
    image: user.image,
    token: user.token,
  );

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
