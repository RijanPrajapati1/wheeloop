import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:wheeloop/app/constants/api_endpoints.dart';
import 'package:wheeloop/features/notification/presentation/view_model/notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final Dio dio;

  NotificationCubit(this.dio) : super(NotificationInitial());

  // Fetch notifications
  Future<void> fetchNotifications() async {
    try {
      emit(NotificationLoading());
      final response = await dio.get("${ApiEndpoints.baseUrl}notification/all");

      if (response.statusCode == 200) {
        // Directly get notifications from the response data
        final notifications = response.data['notifications'];
        emit(NotificationLoaded(notifications: notifications));
      } else {
        emit(const NotificationError(message: "Failed to load notifications"));
      }
    } catch (e) {
      emit(NotificationError(message: e.toString()));
    }
  }
}
