import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:uuid/uuid.dart';
import 'package:wheeloop/app/constants/hive_table_constant.dart';
import 'package:wheeloop/features/auth/domain/entity/auth_entity.dart';

part 'auth_hive_model.g.dart';
// dart run build_runner build -d

@HiveType(typeId: HiveTableConstant.userTableId)
class AuthHiveModel extends Equatable {
  @HiveField(0)
  final String? userId;
  @HiveField(1)
  final String full_name;
  @HiveField(2)
  final String phone_number;
  @HiveField(3)
  final String email;
  @HiveField(4)
  final String address;
  @HiveField(5)
  final String password;
  @HiveField(6)
  final String confirmPassword;

  AuthHiveModel({
    String? userId,
    required this.full_name,
    required this.phone_number,
    required this.email,
    required this.address,
    required this.password,
    required this.confirmPassword,
  }) : userId = userId ?? const Uuid().v4();

  // Initial Constructor
  const AuthHiveModel.initial()
      : userId = '',
        full_name = '',
        phone_number = '',
        email = '',
        address = '',
        password = '',
        confirmPassword = '';

  // From Entity
  factory AuthHiveModel.fromEntity(AuthEntity entity) {
    return AuthHiveModel(
      userId: entity.userId,
      full_name: entity.full_name,
      phone_number: entity.phone_number,
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
      full_name: full_name,
      phone_number: phone_number,
      email: email,
      address: address,
      password: password,
      confirmPassword: confirmPassword,
    );
  }

  @override
  List<Object?> get props => [
        userId,
        full_name,
        phone_number,
        email,
        address,
        password,
        confirmPassword
      ];
}
