import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wheeloop/features/auth/domain/use_case/login_usecase.dart';
import 'package:wheeloop/features/auth/presentation/view/login_screen.dart';
import 'package:wheeloop/features/auth/presentation/view_model/login/login_screen_cubit.dart';
import 'package:wheeloop/features/auth/presentation/view_model/signup/signup_screen_cubit.dart';

// Mock classes for the dependencies
class MockLoginUseCase extends Mock implements LoginUseCase {
  // Define the method in the mock class
  Future<bool> login(String email, String password) async {
    return true; // mock the behavior, assuming it returns a Future<bool>
  }
}

class MockSignUpScreenCubit extends Mock implements SignUpScreenCubit {}

void main() {
  testWidgets('renders correctly', (WidgetTester tester) async {
    final mockLoginUseCase = MockLoginUseCase();
    final mockSignUpScreenCubit = MockSignUpScreenCubit();

    // Build the LoginScreen widget inside a BlocProvider with mocked dependencies.
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<LoginScreenCubit>(
          create: (_) =>
              LoginScreenCubit(mockSignUpScreenCubit, mockLoginUseCase),
          child: const LoginScreen(),
        ),
      ),
    );

    // Check if the expected widgets are rendered
    expect(find.text('Log In'), findsOneWidget);
    expect(find.text('Welcome Back!'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(2)); // for Email and Password
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Signup'), findsOneWidget);
  });

  testWidgets('navigates to signup screen on signup link tap',
      (WidgetTester tester) async {
    final mockLoginUseCase = MockLoginUseCase();
    final mockSignUpScreenCubit = MockSignUpScreenCubit();

    // Build the LoginScreen widget inside a BlocProvider with mocked dependencies.
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<LoginScreenCubit>(
          create: (_) =>
              LoginScreenCubit(mockSignUpScreenCubit, mockLoginUseCase),
          child: const LoginScreen(),
        ),
      ),
    );

    // Tap the "Signup" link.
    await tester.tap(find.text('Signup'));
    await tester.pump();
  });
}
