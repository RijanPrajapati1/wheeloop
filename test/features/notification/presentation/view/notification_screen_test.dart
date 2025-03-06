import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wheeloop/features/notification/presentation/view/notification_screen.dart';
import 'package:wheeloop/features/notification/presentation/view_model/notification_screen_cubit.dart';
import 'package:wheeloop/features/notification/presentation/view_model/notification_state.dart';

// Mock the NotificationCubit
class MockNotificationCubit extends MockCubit<NotificationState>
    implements NotificationCubit {}

void main() {
  late MockNotificationCubit mockCubit;

  setUp(() {
    mockCubit = MockNotificationCubit();
  });

  Widget makeTestableWidget() {
    return MaterialApp(
      home: BlocProvider<NotificationCubit>.value(
        value: mockCubit,
        child: const NotificationScreen(),
      ),
    );
  }

  testWidgets('Displays loading indicator when loading',
      (WidgetTester tester) async {
    when(() => mockCubit.state).thenReturn(NotificationLoading());

    await tester.pumpWidget(makeTestableWidget());
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Displays notifications when loaded',
      (WidgetTester tester) async {
    when(() => mockCubit.state)
        .thenReturn(const NotificationLoaded(notifications: [
      {'title': 'Test Notification 1', 'message': 'Message 1', 'isNew': true},
    ]));

    await tester.pumpWidget(makeTestableWidget());

    await tester.pump(); // Ensure UI rebuilds

    expect(find.text('Test Notification 1'), findsOneWidget);
    expect(find.text('Message 1'), findsOneWidget);
    expect(find.byIcon(Icons.new_releases), findsOneWidget);
  });

  testWidgets('Displays error message when failed',
      (WidgetTester tester) async {
    when(() => mockCubit.state)
        .thenReturn(const NotificationError(message: "Failed to load"));

    await tester.pumpWidget(makeTestableWidget());
    await tester.pump(); // Ensure UI rebuilds

    expect(find.text('Failed to load'), findsOneWidget);
  });

  testWidgets('Displays no notifications available message',
      (WidgetTester tester) async {
    when(() => mockCubit.state)
        .thenReturn(const NotificationLoaded(notifications: []));

    await tester.pumpWidget(makeTestableWidget());
    await tester.pump(); // Ensure UI rebuilds

    expect(find.text('No notifications available.'), findsOneWidget);
  });
}
