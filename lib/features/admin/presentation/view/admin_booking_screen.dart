import 'package:flutter/material.dart';

class AdminBookingsScreen extends StatelessWidget {
  const AdminBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 5, // Dummy bookings
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text("Booking #$index"),
              subtitle: Text("Customer Name: User $index"),
              trailing: const Icon(Icons.check, color: Colors.green),
            ),
          );
        },
      ),
    );
  }
}
