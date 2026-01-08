import 'package:firebase_auth/firebase_auth.dart';
import 'base.exception.dart';

enum AppErrorType {
  invalidCredentials,
  emailAlreadyInUse,
  weakPasswordException,
  serverError,
  unauthenticated,
}

class AppException extends BaseException {
  AppException(super.message, [super.code]);

  factory AppException.fromFirebaseAuth(FirebaseAuthException e) {
    final message = switch (e.code) {
      'weak-password' => 'A senha é muito fraca.',
      'email-already-in-use' => 'Este e-mail já está em uso.',
      'user-not-found' => 'Usuário não encontrado.',
      'wrong-password' => 'Senha incorreta.',
      'invalid-email' => 'Endereço de e-mail inválido.',
      'too-many-requests' =>
        'Muitas tentativas. Por favor, tente novamente mais tarde.',
      'user-disabled' => 'Esta conta foi desativada.',
      'operation-not-allowed' => 'Operação não permitida.',
      'invalid-credential' => 'Credenciais inválidas.',
      'network-request-failed' => 'Erro de conexão. Verifique sua internet.',
      'requires-recent-login' => 'Esta operação requer login recente.',
      'account-exists-with-different-credential' =>
        'Já existe uma conta com as mesmas credenciais.',
      _ => 'Erro de autenticação: ${e.message ?? 'Erro desconhecido'}.',
    };
    return AppException(message, e.code);
  }

  factory AppException.fromType(AppErrorType type) {
    final message = switch (type) {
      AppErrorType.invalidCredentials => 'Credenciais inválidas.',
      AppErrorType.emailAlreadyInUse => 'Este e-mail já está em uso.',
      AppErrorType.weakPasswordException => 'A senha é muito fraca.',
      AppErrorType.serverError =>
        'Erro no servidor. Tente novamente mais tarde.',
      AppErrorType.unauthenticated => 'Usuário não autenticado.',
    };
    return AppException(message, type.toString());
  }

  factory AppException.fromMessage(String message, [String? code]) {
    return AppException(message, code);
  }
}
