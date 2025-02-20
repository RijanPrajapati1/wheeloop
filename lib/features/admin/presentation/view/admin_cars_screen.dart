import 'package:flutter/material.dart';
import 'package:wheeloop/features/admin/presentation/view/admin_add_car_screen.dart';

class AdminCarsScreen extends StatelessWidget {
  const AdminCarsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Manage Cars",
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AdminAddCarScreen()),
                    );
                  },
                  child: const Text("Add Car"),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 5, // Dummy data count
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: const Icon(Icons.directions_car),
                    title: Text("Car Model $index"),
                    subtitle: const Text("Price: Rs. 500/day"),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        // Delete car logic here
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
