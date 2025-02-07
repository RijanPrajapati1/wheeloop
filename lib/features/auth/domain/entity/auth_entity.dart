import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? userId;
  final String name;
  final String? image;
  final String phone;
  final String email;
  final String address;
  final String password;
  final String confirmPassword;

  const AuthEntity({
    this.userId,
    required this.name,
    this.image,
    required this.phone,
    required this.email,
    required this.address,
    required this.password,
    required this.confirmPassword,
  });

  //create an empty constructor or inital constructor
  const AuthEntity.empty()
      : userId = '_empty.userId',
        name = '_empty.name',
        image = '_empty.image',
        phone = '_empty.phone',
        email = '_empty.email',
        address = '_empty.name',
        password = '_empty.password',
        confirmPassword = '_empty.confirmPassword';

  @override
  List<Object?> get props =>
      [userId, name, image, phone, email, address, password, confirmPassword];
}
