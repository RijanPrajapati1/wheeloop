import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheeloop/app/service_locator/service_locator.dart';
import 'package:wheeloop/features/booked_car/presentation/view/booked_car.dart';
import 'package:wheeloop/features/booked_car/presentation/view_model/booked_car_cubit.dart';
import 'package:wheeloop/features/dashboard/presentation/view/bottom_view/home_view.dart';
import 'package:wheeloop/features/dashboard/presentation/view_model/home_cubit.dart';
import 'package:wheeloop/features/notification/presentation/view/notification_screen.dart';
import 'package:wheeloop/features/notification/presentation/view_model/notification_screen_cubit.dart';
import 'package:wheeloop/features/user_profile/view/user_profile.dart';
import 'package:wheeloop/features/user_profile/view_model/user_profile_cubit.dart';

class DashboardState extends Equatable {
  final int selectedIndex;
  final List<Widget> views;

  const DashboardState({
    required this.selectedIndex,
    required this.views,
  });

  // Initialize the state with the default values
  static DashboardState initial() {
    return DashboardState(
      selectedIndex: 0,
      views: [
        BlocProvider<HomeCubit>.value(
          value: serviceLocator<
              HomeCubit>(), // Use the GetIt service locator to provide HomeCubit instance
          child: const HomeScreen(), // HomeScreen which requires HomeCubit
        ),
        BlocProvider<BookedCarCubit>.value(
          value: serviceLocator<BookedCarCubit>(),
          child: const BookedScreen(),
        ),
        BlocProvider<NotificationCubit>.value(
          value: serviceLocator<NotificationCubit>(),
          child: const NotificationScreen(),
        ),
        BlocProvider<UserProfileCubit>.value(
          value: serviceLocator<UserProfileCubit>(),
          child: const UserProfileScreen(
            userId: 'userId',
          ),
        ),
      ],
    );
  }

  // Create a copy of the state with updated values
  DashboardState copyWith({
    int? selectedIndex,
    List<Widget>? views,
  }) {
    return DashboardState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      views: views ?? this.views,
    );
  }

  @override
  List<Object?> get props => [selectedIndex, views];
}
