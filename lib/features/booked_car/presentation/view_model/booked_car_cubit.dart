import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:wheeloop/app/constants/api_endpoints.dart';
import 'package:wheeloop/features/booked_car/presentation/view_model/booked_car_state.dart';

class BookedCarCubit extends Cubit<BookedCarState> {
  final Dio dio;

  BookedCarCubit(this.dio) : super(BookingInitial());

  // Fetch bookings
  Future<void> fetchBookings() async {
    try {
      emit(BookingLoading());
      final response = await dio.get("${ApiEndpoints.baseUrl}rental/all");

      if (response.statusCode == 200) {
        // Directly get bookings from the response data
        final bookings =
            response.data['rentals'] ?? []; // Ensure you handle empty data
        emit(BookingLoaded(bookings: bookings));
      } else {
        emit(const BookingError(message: "Failed to load bookings"));
      }
    } catch (e) {
      emit(BookingError(message: e.toString()));
    }
  }
}
