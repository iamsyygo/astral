enum AuthState {
  initial,
  loading,
  success,
  error;

  bool get isLoading => this == AuthState.loading;
  bool get isSuccess => this == AuthState.success;
  bool get isError => this == AuthState.error;
}
