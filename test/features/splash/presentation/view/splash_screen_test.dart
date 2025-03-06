import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wheeloop/features/splash/presentation/view/splash_screen.dart';
import 'package:wheeloop/features/splash/presentation/view_model/splash_screen_cubit.dart';
import 'package:wheeloop/features/splash/presentation/view_model/splash_screen_state.dart';

// Mock SplashScreenCubit
class MockSplashScreenCubit extends Mock implements SplashScreenCubit {}

void main() {
  late MockSplashScreenCubit mockCubit;

  setUp(() {
    mockCubit = MockSplashScreenCubit();
  });

  Widget createTestWidget(SplashScreenState state) {
    return MaterialApp(
      home: BlocProvider<SplashScreenCubit>.value(
        value: mockCubit,
        child: const SplashScreen(),
      ),
    );
  }

  testWidgets('Displays title and subtitle', (WidgetTester tester) async {
    when(() => mockCubit.state).thenReturn(SplashScreenInitial());

    await tester.pumpWidget(createTestWidget(SplashScreenInitial()));

    expect(find.text('WHEELOOP'), findsOneWidget);
    expect(
        find.text(
            'Rent a luxury car for your travel\nwhenever you want with your device!'),
        findsOneWidget);
  });

  testWidgets('Displays car image', (WidgetTester tester) async {
    when(() => mockCubit.state).thenReturn(SplashScreenInitial());

    await tester.pumpWidget(createTestWidget(SplashScreenInitial()));

    expect(find.byType(SlideTransition), findsOneWidget);
  });

  testWidgets('Displays loading indicator when loading',
      (WidgetTester tester) async {
    when(() => mockCubit.state).thenReturn(SplashScreenLoading());

    await tester.pumpWidget(createTestWidget(SplashScreenLoading()));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
