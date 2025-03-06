import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheeloop/features/notification/presentation/view_model/notification_screen_cubit.dart';
import 'package:wheeloop/features/notification/presentation/view_model/notification_state.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationCubit(Dio())..fetchNotifications(),
      child: Scaffold(
        body: BlocBuilder<NotificationCubit, NotificationState>(
          builder: (context, state) {
            if (state is NotificationLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is NotificationLoaded) {
              if (state.notifications.isEmpty) {
                return const Center(child: Text('No notifications available.'));
              }
              return ListView.builder(
                itemCount: state.notifications.length,
                itemBuilder: (context, index) {
                  final notification = state.notifications[index];
                  return ListTile(
                    title: Text(notification['title']),
                    subtitle: Text(notification['message']),
                    trailing: notification['isNew'] == true
                        ? const Icon(Icons.new_releases, color: Colors.red)
                        : null,
                  );
                },
              );
            } else if (state is NotificationError) {
              return Center(child: Text(state.message));
            }
            return const Center(child: Text('No data available.'));
          },
        ),
      ),
    );
  }
}
