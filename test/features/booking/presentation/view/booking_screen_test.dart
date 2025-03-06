import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wheeloop/features/booking/presentation/view/booking_screen.dart';
import 'package:wheeloop/features/booking/presentation/view_model/booking_cubit.dart';
import 'package:wheeloop/features/booking/presentation/view_model/booking_state.dart';

class MockBookingCubit extends MockCubit<BookingState>
    implements BookingCubit {}

void main() {
  late MockBookingCubit mockBookingCubit;

  setUp(() {
    mockBookingCubit = MockBookingCubit();
  });

  testWidgets('BookingScreen submits the form and handles loading state',
      (WidgetTester tester) async {
    // Arrange: Prepare the widget
    final car = {
      'image': 'https://example.com/car_image.jpg',
      'name': 'Car Name',
      'price': 500,
    };

    when(() => mockBookingCubit.state).thenReturn(BookingInitial());

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: mockBookingCubit,
          child: BookingScreen(car: car),
        ),
      ),
    );

    // Act: Tap on submit button
    await tester.enterText(
        find.byType(TextFormField).at(0), 'John Doe'); // Name
    await tester.enterText(
        find.byType(TextFormField).at(1), '1234567890'); // Contact
    await tester.enterText(
        find.byType(TextFormField).at(2), 'Location'); // Pickup
    await tester.enterText(
        find.byType(TextFormField).at(3), '2023-03-15'); // Start Date
    await tester.enterText(
        find.byType(TextFormField).at(4), '2023-03-20'); // End Date
    await tester.enterText(
        find.byType(TextFormField).at(5), '5'); // Driver Days

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // Assert: Check if the form submission triggers the correct states
    verify(() => mockBookingCubit.handleBooking(any())).called(1);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester
        .pump(const Duration(seconds: 3)); // Allow time for state change
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.text('Proceed to Payment'), findsOneWidget);
  });

  testWidgets('BookingScreen shows snackbar on successful booking',
      (WidgetTester tester) async {
    // Arrange: Prepare the widget and mock the success state
    final car = {
      'image': 'https://example.com/car_image.jpg',
      'name': 'Car Name',
      'price': 500,
    };

    when(() => mockBookingCubit.state).thenReturn(BookingSuccess());

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: mockBookingCubit,
          child: BookingScreen(car: car),
        ),
      ),
    );

    // Act: Tap on submit button
    await tester.enterText(
        find.byType(TextFormField).at(0), 'John Doe'); // Name
    await tester.enterText(
        find.byType(TextFormField).at(1), '1234567890'); // Contact
    await tester.enterText(
        find.byType(TextFormField).at(2), 'Location'); // Pickup
    await tester.enterText(
        find.byType(TextFormField).at(3), '2023-03-15'); // Start Date
    await tester.enterText(
        find.byType(TextFormField).at(4), '2023-03-20'); // End Date
    await tester.enterText(
        find.byType(TextFormField).at(5), '5'); // Driver Days

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // Assert: Check if the success snackbar is shown
    expect(find.text('Booking Created. Proceed to Payment!'), findsOneWidget);
  });
}
