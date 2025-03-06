import 'package:wheeloop/features/notification/data/repository/notification_repo.dart';

class GetNotifications {
  final NotificationRepository repository;

  GetNotifications({required this.repository});

  Future<List> call() async {
    return await repository.getNotifications();
  }
}
