import 'package:equatable/equatable.dart';

class SignUpState extends Equatable {
  final Map<String, String> validationErrors;
  final bool isLoading;
  final bool isSuccess;
  final String? imageName;

  const SignUpState({
    required this.validationErrors,
    required this.isLoading,
    this.isSuccess = false,
    this.imageName,
  });

  factory SignUpState.initial() => const SignUpState(
        validationErrors: {},
        isLoading: false,
      );

  SignUpState copyWith({
    Map<String, String>? validationErrors,
    bool? isLoading,
    bool? isSuccess,
    String? imageName,
  }) {
    return SignUpState(
      validationErrors: validationErrors ?? this.validationErrors,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      imageName: imageName ?? this.imageName,
    );
  }

  @override
  List<Object?> get props =>
      [validationErrors, isLoading, isSuccess, imageName];
}
