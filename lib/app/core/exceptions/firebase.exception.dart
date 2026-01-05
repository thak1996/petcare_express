import 'package:firebase_auth/firebase_auth.dart';

import 'auth.exception.dart';

class AuthErrorMapper {
  static AuthException fromFirebase(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return InvalidCredentialsException();

      case 'email-already-in-use':
        return EmailAlreadyInUseException();

      case 'weak-password':
        return WeakPasswordException();

      case 'network-request-failed':
        return UnknownAuthException(
          "Falha na conexão. Verifique sua internet.",
        );

      case 'user-disabled':
        return UnknownAuthException("Esta conta foi desativada.");

      default:
        return UnknownAuthException("Erro: ${e.code}");
    }
  }
}
