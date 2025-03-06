import 'package:wheeloop/features/notification/data/data_source/notification_datasource.dart';
import 'package:wheeloop/features/notification/data/repository/notification_repo.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource remoteDataSource;

  NotificationRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List> getNotifications() async {
    return await remoteDataSource.fetchNotifications();
  }
}
