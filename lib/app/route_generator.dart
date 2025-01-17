// import 'package:flutter/material.dart';
// import 'package:wheeloop/core/app_theme/app_theme.dart';
// import 'package:wheeloop/screen/dashboard_screen/dashboard_screen.dart';
// import 'package:wheeloop/screen/login/login_screen.dart';
// import 'package:wheeloop/screen/signup/signup_screen.dart';
// import 'package:wheeloop/screen/splash/on_boarding_screen.dart';
// import 'package:wheeloop/screen/splash/splash_screen.dart';

// class RouteGenerator extends StatelessWidget {
//   const RouteGenerator({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       initialRoute: '/',
//       theme: getApplicationTheme(),
//       debugShowCheckedModeBanner: false,
//       routes: {
//         '/': (context) => const SplashScreen(),
//         '/onboarding': (context) => const OnBoardingScreen(),
//         '/login': (context) => const LoginScreen(),
//         '/signup': (context) => const SignUpScreen(),
//         '/dashboard': (context) => const DashboardScreen(),
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheeloop/app/service_locator/service_locator.dart';
import 'package:wheeloop/core/app_theme/app_theme.dart';
import 'package:wheeloop/features/splash/presentation/view/splash_screen.dart';
import 'package:wheeloop/features/splash/presentation/view_model/splash_screen_cubit.dart';

class RouteGenerator extends StatelessWidget {
  const RouteGenerator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getApplicationTheme(),
      debugShowCheckedModeBanner: false,
      home: BlocProvider.value(
        value: serviceLocator<SplashScreenCubit>(),
        child: const SplashScreen(),
      ),
    );
  }
}
