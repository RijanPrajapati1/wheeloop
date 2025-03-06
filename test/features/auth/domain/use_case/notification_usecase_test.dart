import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:wheeloop/features/notification/data/repository/notification_repo.dart';
import 'package:wheeloop/features/notification/domain/use_case/notification_usecase.dart';

class MockNotificationRepository extends Mock
    implements NotificationRepository {}

void main() {
  group('GetNotifications Use Case', () {
    late MockNotificationRepository mockNotificationRepository;
    late GetNotifications getNotifications;

    setUp(() {
      mockNotificationRepository = MockNotificationRepository();
      getNotifications =
          GetNotifications(repository: mockNotificationRepository);
    });

    test(
        'should return a list of notifications when the repository call is successful',
        () async {
      // Arrange: Mock data and behavior
      final notifications = [
        {'id': '1', 'message': 'New booking request', 'date': '2025-03-06'},
        {'id': '2', 'message': 'Car rental approved', 'date': '2025-03-05'}
      ];
      when(() => mockNotificationRepository.getNotifications())
          .thenAnswer((_) async => notifications);

      // Act: Call the use case
      final result = await getNotifications.call();

      // Assert: Verify if the result matches expected notifications
      expect(result, notifications);
      verify(() => mockNotificationRepository.getNotifications()).called(1);
    });

    test('should throw an exception if the repository call fails', () async {
      // Arrange: Mock repository to throw an error
      when(() => mockNotificationRepository.getNotifications())
          .thenThrow(Exception('Failed to fetch notifications'));

      // Act & Assert: Check that the exception is thrown
      expect(() => getNotifications.call(), throwsA(isA<Exception>()));
    });
  });
}
