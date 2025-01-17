import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? userId;
  final String name;
  final String phone;
  final String email;
  final String address;
  final String password;
  final String confirmPassword;

  const AuthEntity({
    this.userId,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    required this.password,
    required this.confirmPassword,
  });

  @override
  List<Object?> get props =>
      [userId, name, phone, email, address, password, confirmPassword];
}
