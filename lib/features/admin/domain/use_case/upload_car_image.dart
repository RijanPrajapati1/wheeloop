import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:wheeloop/app/usecase/usecase.dart';
import 'package:wheeloop/core/error/failure.dart';
import 'package:wheeloop/features/admin/domain/repository/car_repository.dart';

class UploadCarImageParams {
  final File file;

  const UploadCarImageParams({
    required this.file,
  });

  // Empty constructor initializing an empty File object
  UploadCarImageParams.empty() : file = File('');
}

class UploadCarImageUseCase
    implements UsecaseWithParams<String, UploadCarImageParams> {
  final ICarRepository _repository;

  UploadCarImageUseCase(this._repository);

  @override
  Future<Either<Failure, String>> call(UploadCarImageParams params) {
    return _repository.uploadCarImage(params.file);
  }
}
