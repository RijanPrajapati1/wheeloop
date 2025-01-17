import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheeloop/app/service_locator/service_locator.dart';
import 'package:wheeloop/features/dashboard/presentation/view/bottom_view/home_view.dart';
import 'package:wheeloop/features/dashboard/presentation/view_model/home_cubit.dart';

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
        const Center(child: Text('Saved Car')),
        const Center(child: Text('Notification IS HERO IS THE')),
        const Center(child: Text('Profile')),
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
