import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wheeloop/features/auth/presentation/view/login_screen.dart';
import 'package:wheeloop/features/on_boarding_screen/presentation/view/on_boarding_screen.dart';
import 'package:wheeloop/features/on_boarding_screen/presentation/view_model/on_boarding_screen_cubit.dart';

// MockCubit for testing
class MockOnboardingScreenCubit extends MockCubit<int>
    implements OnboardingScreenCubit {}

void main() {
  group('OnboardingScreen', () {
    late OnboardingScreenCubit cubit;

    setUp(() {
      cubit = MockOnboardingScreenCubit();
    });

    testWidgets('displays the onboarding pages and next button works',
        (tester) async {
      // Arrange
      when(() => cubit.state).thenReturn(0); // Set initial page to 0

      await tester.pumpWidget(
        BlocProvider<OnboardingScreenCubit>(
          create: (_) => cubit,
          child: MaterialApp(home: OnboardingScreen()),
        ),
      );

      // Assert: Verify that the first onboarding page is displayed
      expect(find.text('Explore Luxury Cars'), findsOneWidget);

      // Tap the 'Next' button
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();

      // Assert: Verify that the second onboarding page is displayed
      expect(find.text('Easy Booking Process'), findsOneWidget);
    });

    testWidgets('displays the Get Started button on last page', (tester) async {
      // Arrange
      when(() => cubit.state)
          .thenReturn(2); // Set initial page to 2 (last page)

      await tester.pumpWidget(
        BlocProvider<OnboardingScreenCubit>(
          create: (_) => cubit,
          child: MaterialApp(home: OnboardingScreen()),
        ),
      );

      // Assert: Verify that the 'Get Started' button is displayed on the last page
      expect(find.text('Get Started'), findsOneWidget);
    });

    testWidgets('navigates to login screen when Get Started is tapped',
        (tester) async {
      // Arrange
      when(() => cubit.state)
          .thenReturn(2); // Set initial page to 2 (last page)
      await tester.pumpWidget(
        BlocProvider<OnboardingScreenCubit>(
          create: (_) => cubit,
          child: MaterialApp(home: OnboardingScreen()),
        ),
      );

      // Act: Tap the 'Get Started' button
      await tester.tap(find.text('Get Started'));
      await tester.pumpAndSettle();

      // Assert: Verify that the Login screen is pushed onto the navigation stack
      expect(find.byType(LoginScreen), findsOneWidget);
    });
  });
}
