abstract class AuthException implements Exception {
  final String message;
  final String? code;

  AuthException(this.message, {this.code});

  @override
  String toString() => message;
}

class InvalidCredentialsException extends AuthException {
  InvalidCredentialsException() : super("E-mail ou senha incorretos.");
}

class EmailAlreadyInUseException extends AuthException {
  EmailAlreadyInUseException() : super("Este e-mail já está em uso.");
}

class WeakPasswordException extends AuthException {
  WeakPasswordException() : super("A senha é muito fraca.");
}

class UnknownAuthException extends AuthException {
  UnknownAuthException([String? msg])
    : super(msg ?? "Ocorreu um erro inesperado na autenticação.");
}
