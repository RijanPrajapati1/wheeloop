import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:wheeloop/core/error/failure.dart';
import 'package:wheeloop/features/auth/data/data_source/remote_data_source/auth_remote_datasource.dart';
import 'package:wheeloop/features/auth/domain/entity/auth_entity.dart';
import 'package:wheeloop/features/auth/domain/repository/auth_repository.dart';

class AuthRemoteRepository implements IAuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRemoteRepository(this._authRemoteDataSource);

  @override
  Future<Either<Failure, void>> registerUser(AuthEntity user) async {
    try {
      await _authRemoteDataSource.registerUser(user);
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser() async {
    try {
      final user = await _authRemoteDataSource.getCurrentUser();
      return Right(user);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> loginUser(
      String email, String password) async {
    try {
      final token = await _authRemoteDataSource.loginUser(email, password);
      return Right(token);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) async {
    try {
      final imageName = await _authRemoteDataSource.uploadProfilePicture(file);
      return Right(imageName);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
