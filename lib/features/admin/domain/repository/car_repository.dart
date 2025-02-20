import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:wheeloop/core/error/failure.dart';
import 'package:wheeloop/features/admin/domain/entity/car_entity.dart';

abstract interface class ICarRepository {
  Future<Either<Failure, void>> addCar(CarEntity car);

  Future<Either<Failure, List<CarEntity>>> getAllCars();

  Future<Either<Failure, String>> uploadCarImage(File file);
}
