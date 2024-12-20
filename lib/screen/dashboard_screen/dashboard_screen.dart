import 'package:flutter/material.dart';
import 'package:wheeloop/screen/dashboard_screen/bottom_navigation_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: const SafeArea(
        child: BottomNavigationScreen(),
      ),
    );
  }
}
