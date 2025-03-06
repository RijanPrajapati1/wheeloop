import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wheeloop/core/error/failure.dart';

class TokenSharedPrefs {
  final SharedPreferences _sharedPreferences;

  TokenSharedPrefs(this._sharedPreferences);

  Future<Either<Failure, void>> saveToken(String token) async {
    try {
      // Ensure token is always a String
      await _sharedPreferences.setString('token', token.toString());
      return const Right(null);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, String>> getToken() async {
    try {
      final token = _sharedPreferences.getString('token');
      return Right(token ?? '');
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  Future<void> saveUserId(String userId) async {
    await _sharedPreferences.setString('userId', userId); // Save userId only
  }

  Future<String?> getUserId() async {
    return _sharedPreferences.getString('userId'); // Retrieve userId
  }

  // Save Booking ID
  Future<Either<Failure, void>> saveBookingId(String bookingId) async {
    try {
      await _sharedPreferences.setString('bookingId', bookingId);
      return const Right(null);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  Future<void> saveCarId(String carId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'selectedCarId', carId); // Store the carId as a string
  }

  Future<String?> getCarId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('selectedCarId'); // Retrieve the carId as a string
  }

  // Get Booking ID
  Future<Either<Failure, String>> getBookingId() async {
    try {
      final bookingId = _sharedPreferences.getString('bookingId');
      return Right(bookingId ?? '');
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  // Clear All Data (Optional)
  Future<Either<Failure, void>> clearAll() async {
    try {
      await _sharedPreferences.clear();
      return const Right(null);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }
}
