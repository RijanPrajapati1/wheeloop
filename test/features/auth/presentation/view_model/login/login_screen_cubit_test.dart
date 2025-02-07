import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wheeloop/features/auth/domain/use_case/login_usecase.dart';
import 'package:wheeloop/features/auth/presentation/view_model/login/login_screen_cubit.dart';
import 'package:wheeloop/features/auth/presentation/view_model/signup/signup_screen_cubit.dart';
import 'package:wheeloop/features/dashboard/presentation/view_model/dashboard_cubit.dart';

// Register fallback values
class MockLoginUseCase extends Mock implements LoginUseCase {}

class MockSignUpScreenCubit extends Mock implements SignUpScreenCubit {}

class MockDashboardCubit extends Mock implements DashboardCubit {}

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late MockLoginUseCase mockLoginUseCase;
  late MockSignUpScreenCubit mockSignUpScreenCubit;
  late LoginScreenCubit loginCubit;

  setUpAll(() {
    // Register the fallback value for LoginParams
    registerFallbackValue(const LoginParams(email: '', password: ''));
  });

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    mockSignUpScreenCubit = MockSignUpScreenCubit();
    loginCubit = LoginScreenCubit(mockSignUpScreenCubit, mockLoginUseCase);
  });

  test('Password visibility toggle updates state', () {
    // Initial state is true (hidden password)
    expect(loginCubit.state.isPasswordHidden, true);

    // Act
    loginCubit.togglePasswordVisibility();

    // Assert
    expect(loginCubit.state.isPasswordHidden, false);
  });

  // Act
}
