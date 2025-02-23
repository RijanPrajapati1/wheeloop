import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? userId;
  final String full_name;
  final String? image;
  final String phone_number;
  final String email;
  final String address;
  final String password;
  final String confirmPassword;

  const AuthEntity({
    this.userId,
    required this.full_name,
    this.image,
    required this.phone_number,
    required this.email,
    required this.address,
    required this.password,
    required this.confirmPassword,
  });

  //create an empty constructor or inital constructor
  const AuthEntity.empty()
      : userId = '_empty.userId',
        full_name = '_empty.full_name',
        image = '_empty.image',
        phone_number = '_empty.phone_number',
        email = '_empty.email',
        address = '_empty.address',
        password = '_empty.password',
        confirmPassword = '_empty.confirmPassword';

  @override
  List<Object?> get props => [
        userId,
        full_name,
        image,
        phone_number,
        email,
        address,
        password,
        confirmPassword
      ];
}
