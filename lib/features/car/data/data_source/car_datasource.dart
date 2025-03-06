import 'package:dio/dio.dart';
import 'package:wheeloop/features/car/domain/entity/car_entity.dart';

class CarRemoteDataSource {
  final Dio _dio = Dio();
  final String baseUrl = "http://192.168.16.211:3001/api/car/findAll";

  Future<List<Car>> fetchCars() async {
    try {
      final response = await _dio.get(baseUrl);
      if (response.statusCode == 200) {
        List data = response.data;
        return data.map((json) => Car.fromJson(json)).toList();
      } else {
        throw Exception("Failed to fetch cars");
      }
    } catch (e) {
      throw Exception("Error fetching cars: $e");
    }
  }
}
