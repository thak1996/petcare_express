abstract class ForgotState {
  const ForgotState();

  List<Object?> get props => [];
}

class ForgotInitial extends ForgotState {}

class ForgotLoading extends ForgotState {}

class ForgotSuccess extends ForgotState {}

class ForgotError extends ForgotState {
  const ForgotError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
