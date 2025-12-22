import '../../../core/models/login.model.dart';

sealed class LoginState {
  final bool isValid;
  final LoginModel credentials;

  const LoginState({
    this.isValid = false,
    this.credentials = const LoginModel(email: '', password: ''),
  });
}

class LoginInitial extends LoginState {
  const LoginInitial({super.isValid, super.credentials});
}

class LoginLoading extends LoginState {
  const LoginLoading({required super.credentials}) : super(isValid: false);
}

class LoginSuccess extends LoginState {
  const LoginSuccess({required super.credentials}) : super(isValid: false);
}

class LoginError extends LoginState {
  final String message;

  const LoginError(this.message, {required super.credentials})
    : super(isValid: false);
}
