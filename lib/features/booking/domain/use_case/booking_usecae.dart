import 'package:wheeloop/features/booking/data/repository/booking_repo.dart';

class HandleBookingUseCase {
  final BookingRepository _bookingRepository;

  HandleBookingUseCase(this._bookingRepository);

  Future<bool?> call(Map<String, dynamic> bookingData) async {
    return await _bookingRepository.bookCar(bookingData);
  }
}
