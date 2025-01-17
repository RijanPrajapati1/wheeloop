import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheeloop/features/on_boarding_screen/presentation/view/on_boarding_screen.dart';
import 'package:wheeloop/features/on_boarding_screen/presentation/view_model/on_boarding_screen_cubit.dart';
import 'package:wheeloop/features/splash/presentation/view_model/splash_screen_state.dart';

class SplashScreenCubit extends Cubit<SplashScreenState> {
  SplashScreenCubit(this._onboardingScreenCubit) : super(SplashScreenInitial());

  final OnboardingScreenCubit _onboardingScreenCubit;

  // Initialize splash screen logic and navigation
  Future<void> init(BuildContext context) async {
    emit(SplashScreenLoading()); // Emit loading state

    await Future.delayed(const Duration(seconds: 3), () async {
      if (context.mounted) {
        emit(SplashScreenLoaded()); // Emit loaded state after the delay
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: _onboardingScreenCubit,
              child: OnboardingScreen(),
            ),
          ),
        );
      }
    });
  }
}
