import 'package:dio/dio.dart';
import 'package:wheeloop/app/constants/api_endpoints.dart';

class BookingRepository {
  final Dio _dio = Dio();

  Future<bool> bookCar(Map<String, dynamic> bookingData) async {
    try {
      final response = await _dio.post(ApiEndpoints.bookCar,
          data: bookingData); // Use the ApiEndpoints here
      return response.statusCode == 201;
    } catch (e) {
      throw Exception("Error booking car: $e");
    }
  }
}
