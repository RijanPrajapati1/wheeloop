import 'package:wheeloop/features/car/domain/entity/car_entity.dart';

abstract class CarRepository {
  Future<List<Car>> getCars();
  Future<Car> getCarDetails(String id);
}
