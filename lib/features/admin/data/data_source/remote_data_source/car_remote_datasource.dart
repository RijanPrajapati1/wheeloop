// import 'dart:io';

// import 'package:dio/dio.dart';
// import 'package:wheeloop/app/constants/api_endpoints.dart';
// import 'package:wheeloop/features/admin/data/data_source/car_datasource.dart';
// import 'package:wheeloop/features/admin/domain/entity/car_entity.dart';

// class CarRemoteDataSource implements ICarDataSource {
//   final Dio _dio;

//   CarRemoteDataSource(this._dio);

//   @override
//   Future<void> addCar(CarEntity car) async {
//     try {
//       Response response = await _dio.post(
//         ApiEndpoints.addCar,
//         data: {
//           "name": car.name,
//           "brand": car.type, // Replacing type with brand
//           "price": car.price,
//           "description": car.description,
//           "transmission": car.transmission,
//           "image": car.image,
//         },
//       );

//       if (response.statusCode == 201) {
//         return;
//       } else {
//         throw Exception(response.statusMessage);
//       }
//     } on DioException catch (e) {
//       throw Exception(e);
//     } catch (e) {
//       throw Exception(e);
//     }
//   }

//   @override
//   Future<List<CarEntity>> getAllCars() async {
//     try {
//       Response response = await _dio.get(ApiEndpoints.getAllCars);

//       if (response.statusCode == 200) {
//         List<CarEntity> cars = (response.data as List)
//             .map((car) => CarEntity(
//                   id: car['_id'],
//                   name: car['name'],
//                   type: car['brand'], // Replacing type with brand
//                   price: car['price'],
//                   description: car['description'],
//                   transmission: car['transmission'],
//                   image: car['image'],
//                 ))
//             .toList();

//         return cars;
//       } else {
//         throw Exception(response.statusMessage);
//       }
//     } on DioException catch (e) {
//       throw Exception(e);
//     } catch (e) {
//       throw Exception(e);
//     }
//   }

//   @override
//   Future<String> uploadCarImage(File file) async {
//     try {
//       String fileName = file.path.split('/').last;
//       FormData formData = FormData.fromMap({
//         'carImage': await MultipartFile.fromFile(
//           file.path,
//           filename: fileName,
//         ),
//       });

//       Response response = await _dio.post(
//         ApiEndpoints.uploadCarImage,
//         data: formData,
//       );

//       if (response.statusCode == 200) {
//         final imageUrl = response.data['imageUrl']; // Extract image URL
//         return imageUrl;
//       } else {
//         throw Exception(response.statusMessage);
//       }
//     } on DioException catch (e) {
//       throw Exception(e);
//     } catch (e) {
//       throw Exception(e);
//     }
//   }
// }
