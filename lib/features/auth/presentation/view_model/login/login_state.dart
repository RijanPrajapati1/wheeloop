class LoginState {
  final bool isPasswordHidden;
  final bool isLoading;
  final bool isSuccess;

  LoginState({
    required this.isPasswordHidden,
    required this.isLoading,
    required this.isSuccess,
  });

  factory LoginState.initial() {
    return LoginState(
      isPasswordHidden: true,
      isLoading: false,
      isSuccess: false,
    );
  }

  LoginState copyWith({
    bool? isPasswordHidden,
    bool? isLoading,
    bool? isSuccess,
  }) {
    return LoginState(
      isPasswordHidden: isPasswordHidden ?? this.isPasswordHidden,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}
