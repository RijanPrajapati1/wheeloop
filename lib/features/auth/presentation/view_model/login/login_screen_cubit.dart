import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheeloop/features/admin/presentation/view/admin_dashboard_screen.dart';
import 'package:wheeloop/features/auth/domain/use_case/login_usecase.dart';
import 'package:wheeloop/features/auth/presentation/view/signup_screen.dart';
import 'package:wheeloop/features/auth/presentation/view_model/login/login_state.dart';
import 'package:wheeloop/features/auth/presentation/view_model/signup/signup_screen_cubit.dart';
import 'package:wheeloop/features/dashboard/presentation/view/dashboard_view.dart';
import 'package:wheeloop/features/dashboard/presentation/view_model/dashboard_cubit.dart';

class LoginScreenCubit extends Cubit<LoginState> {
  final SignUpScreenCubit _signUpScreenCubit;
  final LoginUseCase _loginUseCase;

  LoginScreenCubit(this._signUpScreenCubit, this._loginUseCase)
      : super(LoginState.initial());

  void login(BuildContext context, String email, String password) async {
    emit(state.copyWith(isLoading: true)); // Show loading state

    if (email == "admin@gmail.com" && password == "password") {
      // Navigate to Admin Dashboard
      emit(state.copyWith(isLoading: false, isSuccess: true));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const AdminDashboardScreen(),
        ),
      );
    } else {
      // Call the login use case for customer login
      final result = await _loginUseCase(
        LoginParams(email: email, password: password),
      );

      result.fold(
        (failure) {
          emit(state.copyWith(isLoading: false, isSuccess: false));
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Invalid email or password!"),
              backgroundColor: Colors.red,
            ),
          );
        },
        (token) {
          emit(state.copyWith(isLoading: false, isSuccess: true));
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                value: DashboardCubit(),
                child: const DashboardScreen(),
              ),
            ),
          );
        },
      );
    }
  }

  // Method to toggle password visibility
  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordHidden: !state.isPasswordHidden));
  }

  // Method to navigate to sign-up screen
  void navigateToSignUp(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: _signUpScreenCubit,
          child: const SignUpScreen(),
        ),
      ),
    );
  }
}
