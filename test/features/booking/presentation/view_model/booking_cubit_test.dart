import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wheeloop/features/booking/domain/use_case/booking_usecae.dart';
import 'package:wheeloop/features/booking/presentation/view_model/booking_cubit.dart';
import 'package:wheeloop/features/booking/presentation/view_model/booking_state.dart';

// Mock the UseCase class
class MockHandleBookingUseCase extends Mock implements HandleBookingUseCase {}

void main() {
  late MockHandleBookingUseCase mockHandleBookingUseCase;
  late BookingCubit bookingCubit;

  setUp(() {
    mockHandleBookingUseCase = MockHandleBookingUseCase();
    bookingCubit = BookingCubit(mockHandleBookingUseCase);
  });

  group('BookingCubit Tests', () {
    test('emits [BookingLoading, BookingSuccess] when booking is successful',
        () async {
      // Arrange
      final bookingData = {'name': 'John Doe', 'contact': '1234567890'};

      when(() => mockHandleBookingUseCase(bookingData))
          .thenAnswer((_) async => true); // Simulate successful booking

      // Act & Assert
      final expected = [
        BookingLoading(),
        BookingSuccess(),
      ];
      expectLater(bookingCubit.stream, emitsInOrder(expected));

      await bookingCubit.handleBooking(bookingData);
    });

    test('emits [BookingLoading, BookingFailure] when booking fails', () async {
      // Arrange
      final bookingData = {'name': 'John Doe', 'contact': '1234567890'};

      when(() => mockHandleBookingUseCase(bookingData))
          .thenThrow(Exception('Booking Failed')); // Simulate an error

      // Act & Assert
      final expected = [
        BookingLoading(),
        BookingFailure('Error: Exception: Booking Failed'),
      ];
      expectLater(bookingCubit.stream, emitsInOrder(expected));

      await bookingCubit.handleBooking(bookingData);
    });
  });
}
