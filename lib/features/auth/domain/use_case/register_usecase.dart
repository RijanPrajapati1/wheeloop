import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:wheeloop/app/usecase/usecase.dart';
import 'package:wheeloop/core/error/failure.dart';
import 'package:wheeloop/features/auth/domain/entity/auth_entity.dart';
import 'package:wheeloop/features/auth/domain/repository/auth_repository.dart';

class RegisterUserParams extends Equatable {
  final String name;
  final String phone;
  final String email;
  final String address;
  final String password;
  final String confirmPassword;

  const RegisterUserParams({
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    required this.password,
    required this.confirmPassword,
  });

  //intial constructor
  const RegisterUserParams.initial({
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    required this.password,
    required this.confirmPassword,
  });

  @override
  List<Object?> get props =>
      [name, phone, email, address, password, confirmPassword];
}

class RegisterUseCase implements UsecaseWithParams<void, RegisterUserParams> {
  final IAuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(RegisterUserParams params) {
    final authEntity = AuthEntity(
      name: params.name,
      phone: params.phone,
      email: params.email,
      address: params.address,
      password: params.password,
      confirmPassword: params.confirmPassword,
    );
    return repository.registerCustomer(authEntity);
  }
}
