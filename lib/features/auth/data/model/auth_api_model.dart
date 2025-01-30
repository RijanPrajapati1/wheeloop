import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wheeloop/features/auth/domain/entity/auth_entity.dart';

part 'auth_api_model.g.dart';

@JsonSerializable()
class AuthApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? userId;
  final String name;
  final String phone;
  final String email;
  final String address;
  final String password;
  final String confirmPassword;

  const AuthApiModel({
    this.userId,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    required this.password,
    required this.confirmPassword,
  });

  // From JSON
  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  // To JSON
  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  // From Entity
  factory AuthApiModel.fromEntity(AuthEntity entity) {
    return AuthApiModel(
      userId: entity.userId,
      name: entity.name,
      phone: entity.phone,
      email: entity.email,
      address: entity.address,
      password: entity.password,
      confirmPassword: entity.confirmPassword,
    );
  }

  // To Entity
  AuthEntity toEntity() {
    return AuthEntity(
      userId: userId,
      name: name,
      phone: phone,
      email: email,
      address: address,
      password: password,
      confirmPassword: confirmPassword,
    );
  }

  @override
  List<Object?> get props =>
      [userId, name, phone, email, address, password, confirmPassword];
}
