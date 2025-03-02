// import 'dart:io';

// import 'package:dartz/dartz.dart';
// import 'package:wheeloop/core/error/failure.dart';
// import 'package:wheeloop/features/admin/data/data_source/remote_data_source/car_remote_datasource.dart';
// import 'package:wheeloop/features/admin/domain/entity/car_entity.dart';
// import 'package:wheeloop/features/admin/domain/repository/car_repository.dart';

// class CarRemoteRepository implements ICarRepository {
//   final CarRemoteDataSource _carRemoteDataSource;

//   CarRemoteRepository(this._carRemoteDataSource);

//   @override
//   Future<Either<Failure, void>> addCar(CarEntity car) async {
//     try {
//       await _carRemoteDataSource.addCar(car);
//       return const Right(null);
//     } catch (e) {
//       return Left(ApiFailure(message: e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, List<CarEntity>>> getAllCars() async {
//     try {
//       final cars = await _carRemoteDataSource.getAllCars();
//       return Right(cars);
//     } catch (e) {
//       return Left(ApiFailure(message: e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, String>> uploadCarImage(File file) async {
//     try {
//       final imageUrl = await _carRemoteDataSource.uploadCarImage(file);
//       return Right(imageUrl);
//     } catch (e) {
//       return Left(ApiFailure(message: e.toString()));
//     }
//   }
// }
