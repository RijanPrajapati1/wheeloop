import 'package:flutter/material.dart';
import 'package:wheeloop/core/app_theme/app_theme.dart';
import 'package:wheeloop/screen/dashboard_screen/dashboard_screen.dart';
import 'package:wheeloop/screen/login/login_screen.dart';
import 'package:wheeloop/screen/signup/signup_screen.dart';
import 'package:wheeloop/screen/splash/on_boarding_screen.dart';
import 'package:wheeloop/screen/splash/splash_screen.dart';

class RouteGenerator extends StatelessWidget {
  const RouteGenerator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      theme: getApplicationTheme(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const SplashScreen(),
        '/onboarding': (context) => const OnBoardingScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/dashboard': (context) => const DashboardScreen(),
      },
    );
  }
}
