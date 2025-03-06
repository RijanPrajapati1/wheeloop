import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wheeloop/features/on_boarding_screen/presentation/view_model/on_boarding_screen_cubit.dart';

void main() {
  group('OnboardingScreenCubit', () {
    late OnboardingScreenCubit cubit;

    setUp(() {
      cubit = OnboardingScreenCubit();
    });

    test('initial state is 0 (first page)', () {
      expect(cubit.state, 0);
    });

    blocTest<OnboardingScreenCubit, int>(
      'emits [1] when nextPage is called and current page is 0',
      build: () => cubit,
      act: (cubit) => cubit.nextPage(),
      expect: () => [1],
    );

    blocTest<OnboardingScreenCubit, int>(
      'emits [2] when nextPage is called and current page is 1',
      build: () => cubit,
      act: (cubit) => cubit.nextPage(),
      expect: () => [2],
    );

    blocTest<OnboardingScreenCubit, int>(
      'does not emit any state when nextPage is called and current page is 2',
      build: () => cubit,
      act: (cubit) => cubit.nextPage(),
      expect: () => [],
    );

    blocTest<OnboardingScreenCubit, int>(
      'emits [1] when previousPage is called and current page is 2',
      build: () => cubit,
      act: (cubit) => cubit.previousPage(),
      expect: () => [1],
    );

    blocTest<OnboardingScreenCubit, int>(
      'does not emit any state when previousPage is called and current page is 0',
      build: () => cubit,
      act: (cubit) => cubit.previousPage(),
      expect: () => [],
    );
  });
}
