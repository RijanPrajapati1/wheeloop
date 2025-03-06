import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wheeloop/features/notification/presentation/view_model/notification_screen_cubit.dart';
import 'package:wheeloop/features/notification/presentation/view_model/notification_state.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late NotificationCubit notificationCubit;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    notificationCubit = NotificationCubit(mockDio);
  });

  tearDown(() {
    notificationCubit.close();
  });

  blocTest<NotificationCubit, NotificationState>(
    'emits [NotificationLoading, NotificationLoaded] when fetchNotifications succeeds',
    build: () {
      when(() => mockDio.get(any())).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: ''),
            statusCode: 200,
            data: {
              'notifications': [
                {
                  'title': 'Test Notification',
                  'message': 'Message 1',
                  'isNew': true
                }
              ],
            },
          ));
      return notificationCubit;
    },
    act: (cubit) => cubit.fetchNotifications(),
    expect: () => [
      NotificationLoading(),
      const NotificationLoaded(notifications: [
        {'title': 'Test Notification', 'message': 'Message 1', 'isNew': true}
      ]),
    ],
  );

  blocTest<NotificationCubit, NotificationState>(
    'emits [NotificationLoading, NotificationError] when fetchNotifications fails',
    build: () {
      when(() => mockDio.get(any())).thenThrow(Exception('Network error'));
      return notificationCubit;
    },
    act: (cubit) => cubit.fetchNotifications(),
    expect: () => [
      NotificationLoading(),
      const NotificationError(message: 'Exception: Network error'),
    ],
  );
}
