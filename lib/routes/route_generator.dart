import 'package:flutter/material.dart';
import 'package:wheeloop/screen/login/login_screen.dart';

class RouteGenerator extends StatelessWidget {
  const RouteGenerator({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: (LoginScreen()),
      debugShowCheckedModeBanner: false,
    );
  }
}
