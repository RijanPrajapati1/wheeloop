import 'package:dio/dio.dart';
import 'package:wheeloop/app/constants/api_endpoints.dart';

class NotificationRemoteDataSource {
  final Dio dio;

  NotificationRemoteDataSource({required this.dio});

  Future<List> fetchNotifications() async {
    final response = await dio.get("${ApiEndpoints.baseUrl}notification/all");

    if (response.statusCode == 200) {
      return response.data['notifications'];
    } else {
      throw Exception("Failed to load notifications");
    }
  }
}
