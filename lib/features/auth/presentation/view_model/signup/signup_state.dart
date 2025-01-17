class SignUpState {
  final Map<String, String> validationErrors;
  final bool isLoading;

  SignUpState({
    required this.validationErrors,
    required this.isLoading,
  });

  factory SignUpState.initial() => SignUpState(
        validationErrors: {},
        isLoading: false,
      );

  SignUpState copyWith({
    Map<String, String>? validationErrors,
    bool? isLoading,
  }) {
    return SignUpState(
      validationErrors: validationErrors ?? this.validationErrors,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
