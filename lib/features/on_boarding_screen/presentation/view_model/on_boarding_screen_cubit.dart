import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheeloop/app/service_locator/service_locator.dart';
import 'package:wheeloop/features/auth/presentation/view/login_screen.dart';
import 'package:wheeloop/features/auth/presentation/view_model/login/login_screen_cubit.dart';

class OnboardingScreenCubit extends Cubit<int> {
  final PageController pageController = PageController(initialPage: 0);

  OnboardingScreenCubit() : super(0);

  void nextPage() {
    if (state < 2) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      emit(state + 1);
    }
  }

  void previousPage() {
    if (state > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      emit(state - 1);
    }
  }

  void updatePage(int index) {
    emit(index);
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }

  void navigateToLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: serviceLocator<LoginScreenCubit>(),
          child: const LoginScreen(),
        ),
      ),
    );
  }
}
