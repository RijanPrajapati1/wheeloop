import 'package:flutter/material.dart';
import 'package:wheeloop/features/admin/presentation/view/admin_booking_screen.dart';
import 'package:wheeloop/features/admin/presentation/view/admin_cars_screen.dart';
import 'package:wheeloop/features/admin/presentation/view/admin_notification_screen.dart';

import 'admin_add_car_screen.dart';
import 'admin_brands_screen.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  _AdminDashboardScreenState createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  Widget _selectedScreen = const AdminCarsScreen(); // Default screen

  void _navigateTo(Widget screen) {
    setState(() {
      _selectedScreen = screen;
    });
    Navigator.pop(context); // Close drawer after selecting
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Admin Dashboard")),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text("Admin Panel",
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
            ListTile(
              leading: const Icon(Icons.directions_car),
              title: const Text("Manage Cars"),
              onTap: () => _navigateTo(const AdminCarsScreen()),
            ),
            ListTile(
              leading: const Icon(Icons.business),
              title: const Text("Manage Brands"),
              onTap: () => _navigateTo(const AdminBrandsScreen()),
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text("View Bookings"),
              onTap: () => _navigateTo(const AdminBookingsScreen()),
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text("Send Notifications"),
              onTap: () => _navigateTo(AdminNotificationsScreen()),
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text("Add New Car"),
              onTap: () => _navigateTo(AdminAddCarScreen()),
            ),
          ],
        ),
      ),
      body: _selectedScreen,
    );
  }
}
