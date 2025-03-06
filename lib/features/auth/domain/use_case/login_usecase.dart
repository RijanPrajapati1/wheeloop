import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:wheeloop/app/shared_prefs/token_shared_prefs.dart';
import 'package:wheeloop/app/usecase/usecase.dart';
import 'package:wheeloop/core/error/failure.dart';
import 'package:wheeloop/features/auth/domain/repository/auth_repository.dart';

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({
    required this.email,
    required this.password,
  });

  // Initial Constructor
  const LoginParams.initial()
      : email = '',
        password = '';

  @override
  List<Object> get props => [email, password];
}

class LoginUseCase implements UsecaseWithParams<String, LoginParams> {
  final IAuthRepository repository;
  final TokenSharedPrefs tokenSharedPrefs;

  LoginUseCase(this.repository, this.tokenSharedPrefs);

  @override
  Future<Either<Failure, String>> call(LoginParams params) async {
    final result = await repository.loginUser(params.email, params.password);

    return result.fold(
      (failure) => Left(failure), // If failure, return error
      (userId) async {
        // Save userId to shared preferences
        await tokenSharedPrefs.saveUserId(userId); // Save only the userId

        // For debugging, print saved userId
        String? savedUserId = await tokenSharedPrefs.getUserId();
        print('Saved userId: $savedUserId');

        return Right(userId); // Return userId on success
      },
    );
  }
}
