import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wheeloop/features/car/data/model/car_model.dart';

class CarRepository {
  // ✅ Correct API link to fetch cars
  final String apiUrl = "http://10.0.2.2:3001/api/car/findAll";

  Future<List<CarModel>> getAllCars() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => CarModel.fromJson(json)).toList();
    } else {
      throw Exception("Failed to fetch cars");
    }
  }
}
