import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheeloop/features/dashboard/presentation/view_model/dashboard_cubit.dart';
import 'package:wheeloop/features/dashboard/presentation/view_model/dashboard_state.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
        ),
        body: BlocBuilder<DashboardCubit, DashboardState>(
          builder: (context, state) {
            return state
                .views[state.selectedIndex]; // Display the selected view
          },
        ),
        bottomNavigationBar: BlocBuilder<DashboardCubit, DashboardState>(
          builder: (context, state) {
            return BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.bookmark),
                  label: 'Saved Car',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.notifications),
                  label: 'Notification',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
              backgroundColor: Colors.deepPurple,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.black,
              currentIndex: state.selectedIndex, // Sync with selected index
              onTap: (index) {
                context
                    .read<DashboardCubit>()
                    .onTabTapped(index); // Update selected index
              },
            );
          },
        ),
      ),
    );
  }
}
