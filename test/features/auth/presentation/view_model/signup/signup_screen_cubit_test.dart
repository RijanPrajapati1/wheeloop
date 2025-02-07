import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wheeloop/core/error/failure.dart';
import 'package:wheeloop/features/auth/domain/use_case/register_usecase.dart';
import 'package:wheeloop/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:wheeloop/features/auth/presentation/view_model/signup/signup_screen_cubit.dart';
import 'package:wheeloop/features/auth/presentation/view_model/signup/signup_state.dart';

// Mocks
class MockRegisterUseCase extends Mock implements RegisterUseCase {}

class MockUploadImageUsecase extends Mock implements UploadImageUsecase {}

class FakeUploadImageParams extends Fake implements UploadImageParams {}

class FakeRegisterUserParams extends Fake implements RegisterUserParams {}

class FakeBuildContext extends Fake implements BuildContext {
  final ScaffoldMessengerState scaffoldMessengerState =
      ScaffoldMessengerState();

  @override
  ScaffoldMessengerState? get scaffoldMessenger => scaffoldMessengerState;
}

void main() {
  late SignUpScreenCubit cubit;
  late MockRegisterUseCase mockRegisterUseCase;
  late MockUploadImageUsecase mockUploadImageUsecase;

  setUp(() {
    mockRegisterUseCase = MockRegisterUseCase();
    mockUploadImageUsecase = MockUploadImageUsecase();
    registerFallbackValue(FakeUploadImageParams());
    registerFallbackValue(FakeRegisterUserParams());
    cubit = SignUpScreenCubit(
      registerUseCase: mockRegisterUseCase,
      uploadImageUsecase: mockUploadImageUsecase,
    );
  });

  tearDown(() {
    cubit.close();
  });

  test('Initial state should be SignUpState.initial()', () {
    expect(cubit.state, SignUpState.initial());
  });

  blocTest<SignUpScreenCubit, SignUpState>(
    'Should emit validation errors when inputs are invalid',
    build: () => cubit,
    act: (cubit) {
      cubit.validateForm();
    },
    expect: () => [
      const SignUpState(validationErrors: {
        'name': 'Please enter your full name',
        'phone': 'Please enter your phone number',
        'email': 'Please enter your email address',
        'address': 'Please enter your full address',
        'password': 'Please enter a password',
        'confirmPassword': 'Please confirm your password',
      }, isLoading: false),
    ],
  );

  blocTest<SignUpScreenCubit, SignUpState>(
    'Should upload an image successfully',
    build: () => cubit,
    setUp: () {
      final file = File('test.jpg');
      when(() => mockUploadImageUsecase.call(any()))
          .thenAnswer((_) async => const Right('https://example.com/test.jpg'));
    },
    act: (cubit) async {
      await cubit.uploadImage(File('test.jpg'));
    },
    expect: () => [
      const SignUpState(isLoading: true, validationErrors: {}),
      const SignUpState(
        isLoading: false,
        isSuccess: true,
        validationErrors: {},
        imageName: 'https://example.com/test.jpg',
      ),
    ],
  );

  blocTest<SignUpScreenCubit, SignUpState>(
    'Should handle image upload failure',
    build: () => cubit,
    setUp: () {
      when(() => mockUploadImageUsecase.call(any())).thenAnswer(
          (_) async => const Left(ApiFailure(message: 'Image upload failed')));
    },
    act: (cubit) async {
      await cubit.uploadImage(File('test.jpg'));
    },
    expect: () => [
      const SignUpState(isLoading: true, validationErrors: {}),
      const SignUpState(
          isLoading: false, isSuccess: false, validationErrors: {}),
    ],
  );

  blocTest<SignUpScreenCubit, SignUpState>(
    'Should register user successfully',
    build: () => cubit,
    setUp: () {
      when(() => mockRegisterUseCase.call(any()))
          .thenAnswer((_) async => const Right(Unit));
      cubit.nameController.text = 'John Doe';
      cubit.phoneController.text = '1234567890';
      cubit.emailController.text = 'test@example.com';
      cubit.addressController.text = '123 Street';
      cubit.passwordController.text = 'password123';
      cubit.confirmPasswordController.text = 'password123';
    },
    act: (cubit) async {
      final fakeContext = FakeBuildContext();
      await cubit.signUp(fakeContext);
    },
    expect: () => [
      const SignUpState(isLoading: true, validationErrors: {}),
      const SignUpState(
        isLoading: false,
        isSuccess: true,
        validationErrors: {},
      ),
    ],
  );

  blocTest<SignUpScreenCubit, SignUpState>(
    'Should handle registration failure',
    build: () => cubit,
    setUp: () {
      when(() => mockRegisterUseCase.call(any())).thenAnswer(
          (_) async => const Left(ApiFailure(message: 'Registration failed')));
      cubit.nameController.text = 'John Doe';
      cubit.phoneController.text = '1234567890';
      cubit.emailController.text = 'test@example.com';
      cubit.addressController.text = '123 Street';
      cubit.passwordController.text = 'password123';
      cubit.confirmPasswordController.text = 'password123';
    },
    act: (cubit) async {
      final fakeContext = FakeBuildContext();
      await cubit.signUp(fakeContext);
    },
    expect: () => [
      const SignUpState(isLoading: true, validationErrors: {}),
      const SignUpState(
          isLoading: false, isSuccess: false, validationErrors: {}),
    ],
  );
}
