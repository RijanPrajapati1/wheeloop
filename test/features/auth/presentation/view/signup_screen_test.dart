import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wheeloop/features/auth/domain/use_case/register_usecase.dart';
import 'package:wheeloop/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:wheeloop/features/auth/presentation/view/signup_screen.dart';
import 'package:wheeloop/features/auth/presentation/view_model/signup/signup_screen_cubit.dart';

// Mock classes for the dependencies
class MockRegisterUseCase extends Mock implements RegisterUseCase {}

class MockUploadImageUsecase extends Mock implements UploadImageUsecase {}

void main() {
  // testWidgets('validate form fields', (WidgetTester tester) async {
  //   final mockRegisterUseCase = MockRegisterUseCase();
  //   final mockUploadImageUsecase = MockUploadImageUsecase();

  //   // Build the SignUpScreen widget inside a BlocProvider with mocked dependencies.
  //   await tester.pumpWidget(
  //     MaterialApp(
  //       home: BlocProvider<SignUpScreenCubit>(
  //         create: (_) => SignUpScreenCubit(
  //           registerUseCase: mockRegisterUseCase,
  //           uploadImageUsecase: mockUploadImageUsecase,
  //         ),
  //         child: const SignUpScreen(),
  //       ),
  //     ),
  //   );

  //   // Enter text in form fields
  //   await tester.enterText(find.byType(TextFormField).at(0), 'John Doe');
  //   await tester.enterText(find.byType(TextFormField).at(1), '1234567890');
  //   await tester.enterText(
  //       find.byType(TextFormField).at(2), 'john.doe@example.com');
  //   await tester.enterText(
  //       find.byType(TextFormField).at(3), '123 Street, City');
  //   await tester.enterText(find.byType(TextFormField).at(4), 'password123');
  //   await tester.enterText(find.byType(TextFormField).at(5), 'password123');

  //   // Tap on the sign up button with Key
  //   await tester.tap(find.byKey(const Key('sign_up_button')));
  //   await tester.pump();

  //   // Validate that the form was successfully submitted
  //   // Add additional checks based on the logic you have for successful sign up
  //   verify(() => mockRegisterUseCase.call(any())).called(1);
  // });

  testWidgets('navigate to login screen on login link tap',
      (WidgetTester tester) async {
    final mockRegisterUseCase = MockRegisterUseCase();
    final mockUploadImageUsecase = MockUploadImageUsecase();

    // Build the SignUpScreen widget inside a BlocProvider with mocked dependencies.
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<SignUpScreenCubit>(
          create: (_) => SignUpScreenCubit(
            registerUseCase: mockRegisterUseCase,
            uploadImageUsecase: mockUploadImageUsecase,
          ),
          child: const SignUpScreen(),
        ),
      ),
    );

    // Tap the "Login" link
    await tester.tap(find.text('Login'));
    await tester.pump();

    // Ensure the login navigation occurs here
    // This can be tested by checking if the LoginScreen is pushed or an action occurs
  });
}
