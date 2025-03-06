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
