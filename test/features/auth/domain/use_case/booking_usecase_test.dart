import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:wheeloop/features/booking/data/repository/booking_repo.dart';
import 'package:wheeloop/features/booking/domain/use_case/booking_usecae.dart';

class MockBookingRepository extends Mock implements BookingRepository {}

void main() {
  group('HandleBookingUseCase', () {
    late MockBookingRepository mockBookingRepository;
    late HandleBookingUseCase handleBookingUseCase;

    setUp(() {
      mockBookingRepository = MockBookingRepository();
      handleBookingUseCase = HandleBookingUseCase(mockBookingRepository);
    });

    test('should return true when booking is successful', () async {
      // Arrange: Mock the repository to return true when booking is successful
      final bookingData = {
        'carId': '123',
        'userId': '456',
        'rentalPeriod': '7 days',
      };
      when(() => mockBookingRepository.bookCar(bookingData))
          .thenAnswer((_) async => true);

      // Act: Call the use case
      final result = await handleBookingUseCase.call(bookingData);

      // Assert: Verify that the result is true, indicating the booking was successful
      expect(result, true);
      verify(() => mockBookingRepository.bookCar(bookingData)).called(1);
    });

    test('should return false when booking fails', () async {
      // Arrange: Mock the repository to return false when booking fails
      final bookingData = {
        'carId': '123',
        'userId': '456',
        'rentalPeriod': '7 days',
      };
      when(() => mockBookingRepository.bookCar(bookingData))
          .thenAnswer((_) async => false);

      // Act: Call the use case
      final result = await handleBookingUseCase.call(bookingData);

      // Assert: Verify that the result is false, indicating the booking failed
      expect(result, false);
      verify(() => mockBookingRepository.bookCar(bookingData)).called(1);
    });

    test('should throw an exception when booking throws an error', () async {
      // Arrange: Mock the repository to throw an exception
      final bookingData = {
        'carId': '123',
        'userId': '456',
        'rentalPeriod': '7 days',
      };
      when(() => mockBookingRepository.bookCar(bookingData))
          .thenThrow(Exception('Booking failed'));

      // Act & Assert: Check that the exception is thrown
      expect(() => handleBookingUseCase.call(bookingData),
          throwsA(isA<Exception>()));
    });
  });
}
