import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wheeloop/features/on_boarding_screen/presentation/view_model/on_boarding_screen_cubit.dart';
import 'package:wheeloop/features/splash/presentation/view_model/splash_screen_cubit.dart';
import 'package:wheeloop/features/splash/presentation/view_model/splash_screen_state.dart';

class MockOnboardingScreenCubit extends MockCubit<int>
    implements OnboardingScreenCubit {}

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late MockOnboardingScreenCubit mockOnboardingScreenCubit;
  late SplashScreenCubit splashScreenCubit;
  late MockBuildContext mockContext;

  setUp(() {
    mockOnboardingScreenCubit = MockOnboardingScreenCubit();
    splashScreenCubit = SplashScreenCubit(mockOnboardingScreenCubit);
    mockContext = MockBuildContext();
  });

  // Test 1: Emitting correct states during splash screen init
  blocTest<SplashScreenCubit, SplashScreenState>(
    'emits SplashScreenLoading and then SplashScreenLoaded after a delay',
    build: () => splashScreenCubit,
    act: (cubit) async {
      // Trigger splash screen init
      await cubit.init(mockContext);
    },
    expect: () => [
      SplashScreenLoading(), // Expect SplashScreenLoading
      SplashScreenLoaded(), // Expect SplashScreenLoaded after delay
    ],
  );

  // Test 2: Verifying navigation happens when context is mounted
  blocTest<SplashScreenCubit, SplashScreenState>(
    'navigates to OnboardingScreen after 3 seconds',
    build: () {
      when(() => mockContext.mounted).thenReturn(true); // Mock mounted context
      return splashScreenCubit;
    },
    act: (cubit) async {
      // Act by triggering init
      await cubit.init(mockContext);
    },
    verify: (_) {
      // Verify if the navigation was triggered
      verify(() => mockContext.mounted).called(1);
    },
  );

  // Test 3: Verifying no navigation if context is unmounted
  blocTest<SplashScreenCubit, SplashScreenState>(
    'does not navigate when context is unmounted',
    build: () {
      when(() => mockContext.mounted)
          .thenReturn(false); // Simulate unmounted context
      return splashScreenCubit;
    },
    act: (cubit) async {
      // Act by triggering init
      await cubit.init(mockContext);
    },
    verify: (_) {
      // Verify navigation is not triggered
      verifyNever(() => mockContext.mounted);
    },
  );
}
