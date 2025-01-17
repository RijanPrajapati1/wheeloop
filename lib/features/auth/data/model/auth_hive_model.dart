import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:uuid/uuid.dart';
import 'package:wheeloop/app/constants/hive_table_constant.dart';
import 'package:wheeloop/features/auth/domain/entity/auth_entity.dart';

part 'auth_hive_model.g.dart';
// dart run build_runner build -d

@HiveType(typeId: HiveTableConstant.customerTableId)
class AuthHiveModel extends Equatable {
  @HiveField(0)
  final String? customerId;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String phone;
  @HiveField(3)
  final String email;
  @HiveField(4)
  final String address;
  @HiveField(5)
  final String password;
  @HiveField(6)
  final String confirmPassword;

  AuthHiveModel({
    String? customerId,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    required this.password,
    required this.confirmPassword,
  }) : customerId = customerId ?? const Uuid().v4();

  // Initial Constructor
  const AuthHiveModel.initial()
      : customerId = '',
        name = '',
        phone = '',
        email = '',
        address = '',
        password = '',
        confirmPassword = '';

  // From Entity
  factory AuthHiveModel.fromEntity(AuthEntity entity) {
    return AuthHiveModel(
      customerId: entity.userId,
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
      userId: customerId,
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
      [customerId, name, phone, email, address, password, confirmPassword];
}
