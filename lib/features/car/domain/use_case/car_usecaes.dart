import 'package:wheeloop/features/car/data/repository/car_repo.dart';
import 'package:wheeloop/features/car/domain/entity/car_entity.dart';

class GetCars {
  final CarRepository repository;

  GetCars(this.repository);

  Future<List<Car>> call() async {
    return await repository.getCars();
  }
}

class GetCarDetails {
  final CarRepository repository;

  GetCarDetails(this.repository);

  Future<Car> call(String id) async {
    return await repository.getCarDetails(id);
  }
}
