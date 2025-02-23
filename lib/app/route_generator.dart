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
import 'package:wheeloop/features/admin/presentation/view_model/admin_car_cubit.dart';
import 'package:wheeloop/features/admin/presentation/view_model/admin_fetching_car_cubit.dart';
import 'package:wheeloop/features/auth/presentation/view_model/login/login_screen_cubit.dart';
import 'package:wheeloop/features/auth/presentation/view_model/signup/signup_screen_cubit.dart';
import 'package:wheeloop/features/dashboard/presentation/view_model/dashboard_cubit.dart';
import 'package:wheeloop/features/dashboard/presentation/view_model/home_cubit.dart';
import 'package:wheeloop/features/on_boarding_screen/presentation/view_model/on_boarding_screen_cubit.dart';
import 'package:wheeloop/features/splash/presentation/view/splash_screen.dart';
import 'package:wheeloop/features/splash/presentation/view_model/splash_screen_cubit.dart';

class RouteGenerator extends StatelessWidget {
  const RouteGenerator({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<SplashScreenCubit>()),
        BlocProvider(create: (_) => serviceLocator<OnboardingScreenCubit>()),
        BlocProvider(create: (_) => serviceLocator<LoginScreenCubit>()),
        BlocProvider(create: (_) => serviceLocator<SignUpScreenCubit>()),
        BlocProvider(create: (_) => serviceLocator<AdminCarCubit>()),
        BlocProvider(create: (_) => serviceLocator<AdminFetchCarCubit>()),
        BlocProvider(create: (_) => serviceLocator<HomeCubit>()),
        BlocProvider(create: (_) => serviceLocator<DashboardCubit>()),
      ],
      child: MaterialApp(
        theme: getApplicationTheme(),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
