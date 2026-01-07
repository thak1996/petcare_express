abstract class RegisterState {
  const RegisterState();

  List<Object?> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterError extends RegisterState {
  const RegisterError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
