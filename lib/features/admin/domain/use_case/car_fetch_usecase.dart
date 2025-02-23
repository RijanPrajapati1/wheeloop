import 'package:dartz/dartz.dart';
import 'package:wheeloop/app/usecase/usecase.dart';
import 'package:wheeloop/core/error/failure.dart';
import 'package:wheeloop/features/admin/domain/entity/car_entity.dart';
import 'package:wheeloop/features/admin/domain/repository/car_repository.dart';

class GetAllCarsUseCase implements UsecaseWithoutParams<List<CarEntity>> {
  final ICarRepository repository;

  GetAllCarsUseCase(this.repository);

  @override
  Future<Either<Failure, List<CarEntity>>> call() {
    return repository.getAllCars();
  }
}

// class DeleteCarUseCase implements UsecaseWithParams<void, String> {
//   final ICarRepository repository;

//   DeleteCarUseCase(this.repository);

//   @override
//   Future<Either<Failure, void>> call(String carId) {
//     return repository.deleteCar(carId);
//   }
// }
