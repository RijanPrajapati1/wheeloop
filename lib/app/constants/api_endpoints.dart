class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);

  static const String baseUrl = "http://10.0.2.2:3001/api/";

  // For iPhone
  //static const String baseUrl = "http://localhost:3000/api/v1/";

  // ====================== Auth Routes ======================
  static const String login = "auth/login";
  static const String register = "auth/register";

  static const String getAllUser = "auth/getAllUsers";
  static const String updateUser = "auth/updateUser/";
  static const String deleteUser = "auth/deleteUser/";
  static const String imageUrl = "http://10.0.2.2:3001/uploads/";

  static const String uploadImage = "auth/uploadImage";
}
