import 'package:wheeloop/features/car/data/data_source/car_datasource.dart';
import 'package:wheeloop/features/car/data/repository/car_repo.dart';
import 'package:wheeloop/features/car/domain/entity/car_entity.dart';

class CarRepositoryImpl implements CarRepository {
  final CarRemoteDataSource remoteDataSource;

  CarRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Car>> getCars() async {
    return await remoteDataSource.fetchCars();
  }

  @override
  Future<Car> getCarDetails(String id) {
    // TODO: implement getCarDetails
    throw UnimplementedError();
  }
}
