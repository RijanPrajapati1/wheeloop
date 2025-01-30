import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheeloop/app/service_locator/service_locator.dart';
import 'package:wheeloop/features/auth/domain/use_case/register_usecase.dart';
import 'package:wheeloop/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:wheeloop/features/auth/presentation/view/login_screen.dart';
import 'package:wheeloop/features/auth/presentation/view_model/login/login_screen_cubit.dart';
import 'package:wheeloop/features/auth/presentation/view_model/signup/signup_state.dart';

class SignUpScreenCubit extends Cubit<SignUpState> {
  final RegisterUseCase _registerUseCase;
  final UploadImageUsecase _uploadImageUsecase;

  SignUpScreenCubit({
    required RegisterUseCase registerUseCase,
    required UploadImageUsecase uploadImageUsecase,
  })  : _registerUseCase = registerUseCase,
        _uploadImageUsecase = uploadImageUsecase,
        super(SignUpState.initial());

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // Event: Validate the form
  void validateForm() {
    final errors = <String, String>{};

    if (nameController.text.isEmpty) {
      errors['name'] = 'Please enter your full name';
    }
    if (phoneController.text.isEmpty) {
      errors['phone'] = 'Please enter your phone number';
    } else if (phoneController.text.length != 10) {
      errors['phone'] = 'Phone number must be exactly 10 digits';
    }
    if (emailController.text.isEmpty) {
      errors['email'] = 'Please enter your email address';
    } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(emailController.text)) {
      errors['email'] = 'Please enter a valid email address';
    }
    if (addressController.text.isEmpty) {
      errors['address'] = 'Please enter your full address';
    }
    if (passwordController.text.isEmpty) {
      errors['password'] = 'Please enter a password';
    } else if (passwordController.text.length < 6) {
      errors['password'] = 'Password must be at least 6 characters';
    }
    if (confirmPasswordController.text.isEmpty) {
      errors['confirmPassword'] = 'Please confirm your password';
    } else if (confirmPasswordController.text != passwordController.text) {
      errors['confirmPassword'] = 'Passwords do not match';
    }

    emit(state.copyWith(validationErrors: errors));
  }

  // Event: Handle signup using UseCase
  Future<void> signUp(BuildContext context) async {
    validateForm();
    if (state.validationErrors.isEmpty) {
      emit(state.copyWith(isLoading: true));

      // Create the parameters for the use case
      final registerUserParams = RegisterUserParams(
        name: nameController.text,
        phone: phoneController.text,
        email: emailController.text,
        address: addressController.text,
        password: passwordController.text,
        confirmPassword: confirmPasswordController.text,
      );

      // Call the UseCase
      final result = await _registerUseCase.call(registerUserParams);

      // Handle the result (success or failure)
      result.fold(
        (failure) {
          emit(state.copyWith(isLoading: false));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(failure.message)),
          );
        },
        (success) {
          emit(state.copyWith(isLoading: false));
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Signup successful! Redirecting to Login')),
          );
          navigateToLogin(context);
        },
      );
    }
  }

  // Event: Navigate to Login Screen
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

  // Image Upload Event
  void uploadImage(File file) async {
    emit(state.copyWith(isLoading: true));
    final result = await _uploadImageUsecase.call(
      UploadImageParams(file: file),
    );

    result.fold(
      (l) => emit(state.copyWith(isLoading: false, isSuccess: false)),
      (r) {
        emit(state.copyWith(isLoading: false, isSuccess: true, imageName: r));
      },
    );
  }
}
