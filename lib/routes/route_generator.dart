import 'package:flutter/material.dart';
import 'package:wheeloop/screen/dashboard_screen/dashboard_screen.dart';
import 'package:wheeloop/screen/login/login_screen.dart';
import 'package:wheeloop/screen/signup/signup_screen.dart';

import 'package:wheeloop/screen/splash/splash_screen.dart';

class RouteGenerator extends StatelessWidget {
  const RouteGenerator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/dashboard': (context) => const DashboardScreen(),
      },
    );
  }
}
