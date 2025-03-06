import 'package:bloc/bloc.dart';
import 'package:wheeloop/features/booking/domain/use_case/booking_usecae.dart';
import 'package:wheeloop/features/booking/presentation/view_model/booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  final HandleBookingUseCase _handleBookingUseCase;

  BookingCubit(this._handleBookingUseCase) : super(BookingInitial());

  Future<void> handleBooking(Map<String, dynamic> bookingData) async {
    emit(BookingLoading());

    try {
      final result = await _handleBookingUseCase(bookingData);

      if (result != null) {
        emit(BookingSuccess());
      } else {
        emit(BookingFailure("Booking Failed. Please try again."));
      }
    } catch (e) {
      emit(BookingFailure("Error: $e"));
    }
  }
}
