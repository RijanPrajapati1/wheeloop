import 'package:flutter/material.dart';

class AdminBrandsScreen extends StatelessWidget {
  const AdminBrandsScreen({super.key});

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
                const Text("Manage Brands",
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                ElevatedButton(
                  onPressed: () {
                    // Add brand logic
                  },
                  child: const Text("Add Brand"),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 3, // Dummy brands
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text("Brand $index"),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        // Delete brand logic
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
