sealed class ForgotState {
  const ForgotState();

  List<Object?> get props => [];
}

final class ForgotInitial extends ForgotState {}

final class ForgotLoading extends ForgotState {}

final class ForgotSuccess extends ForgotState {}

final class ForgotError extends ForgotState {
  const ForgotError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
