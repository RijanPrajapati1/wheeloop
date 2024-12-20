import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(hintText: 'Type anything'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: () {}, child: const Text('press me'))
          ],
        ),
      ),
    );
  }
}
