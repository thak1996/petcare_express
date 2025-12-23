abstract class ForgotState {
  const ForgotState();
}

class ForgotInitial extends ForgotState {
  const ForgotInitial();
}

class ForgotLoading extends ForgotState {
  const ForgotLoading();
}

class ForgotSuccess extends ForgotState {
  const ForgotSuccess();
}

class ForgotError extends ForgotState {
  final String message;

  const ForgotError(this.message);
}
