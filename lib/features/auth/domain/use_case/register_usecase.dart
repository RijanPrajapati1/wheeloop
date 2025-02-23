import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:wheeloop/app/usecase/usecase.dart';
import 'package:wheeloop/core/error/failure.dart';
import 'package:wheeloop/features/auth/domain/entity/auth_entity.dart';
import 'package:wheeloop/features/auth/domain/repository/auth_repository.dart';

class RegisterUserParams extends Equatable {
  final String full_name;
  final String phone_number;
  final String email;
  final String address;
  final String password;
  final String confirmPassword;
  final String? image;

  const RegisterUserParams({
    required this.full_name,
    required this.phone_number,
    required this.email,
    required this.address,
    required this.password,
    required this.confirmPassword,
    this.image,
  });

  //intial constructor
  const RegisterUserParams.initial({
    required this.full_name,
    required this.phone_number,
    required this.email,
    required this.address,
    required this.password,
    required this.confirmPassword,
    this.image,
  });

  //create an empty constructor or inital constructor
  const RegisterUserParams.empty()
      : full_name = '_empty.full_name',
        image = '_empty.image',
        phone_number = '_empty.phone_number',
        email = '_empty.email',
        address = '_empty.name',
        password = '_empty.password',
        confirmPassword = '_empty.confirmPassword';

  @override
  List<Object?> get props => [
        full_name,
        phone_number,
        email,
        address,
        password,
        confirmPassword,
        image
      ];
}

class RegisterUseCase implements UsecaseWithParams<void, RegisterUserParams> {
  final IAuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(RegisterUserParams params) {
    final authEntity = AuthEntity(
      full_name: params.full_name,
      phone_number: params.phone_number,
      email: params.email,
      address: params.address,
      password: params.password,
      confirmPassword: params.confirmPassword,
      image: params.image,
    );
    return repository.registerUser(authEntity);
  }
}
