import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:wheeloop/app/usecase/usecase.dart';
import 'package:wheeloop/core/error/failure.dart';
import 'package:wheeloop/features/auth/domain/repository/auth_repository.dart';

class UploadImageParams {
  final File file;

  const UploadImageParams({
    required this.file,
  });

  // Empty constructor initializing an empty File object
  UploadImageParams.empty() : file = File('');
}

class UploadImageUsecase
    implements UsecaseWithParams<String, UploadImageParams> {
  final IAuthRepository _repository;

  UploadImageUsecase(this._repository);

  @override
  Future<Either<Failure, String>> call(UploadImageParams params) {
    return _repository.uploadProfilePicture(params.file);
  }
}
