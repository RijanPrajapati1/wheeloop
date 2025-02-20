import 'package:flutter/material.dart';

class AdminNotificationsScreen extends StatelessWidget {
  final TextEditingController _notificationController = TextEditingController();

  AdminNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text("Send Notification",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            TextField(
              controller: _notificationController,
              decoration:
                  const InputDecoration(labelText: "Enter Notification"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Send notification logic here
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Notification Sent!")),
                );
              },
              child: const Text("Send"),
            ),
          ],
        ),
      ),
    );
  }
}
