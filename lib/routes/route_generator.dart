import 'package:flutter/material.dart';
import 'package:wheeloop/screen/splash/splash_screen.dart';

class RouteGenerator extends StatelessWidget {
  const RouteGenerator({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: (SplashScreen()),
      debugShowCheckedModeBanner: false,
    );
  }
}
