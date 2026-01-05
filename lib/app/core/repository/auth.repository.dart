import 'package:result_dart/result_dart.dart';
import '../models/auth/login.model.dart';
import '../models/auth/register.model.dart';
import '../service/storage/token.storage.dart';

abstract class IAuthRepository {
  AsyncResult<Unit> loginWithEmail(LoginModel loginModel);
  AsyncResult<Unit> register(RegisterModel registerModel);
  AsyncResult<Unit> forgotPassword(LoginModel loginModel);
  AsyncResult<Unit> logout();
}

class AuthRepositoryImpl implements IAuthRepository {
  final ITokenStorage _tokenStorage;

  AuthRepositoryImpl(this._tokenStorage);

  @override
  AsyncResult<Unit> loginWithEmail(LoginModel loginModel) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      if (loginModel.email == "admin@petcare.com" &&
          loginModel.password == "12345678") {
        await _tokenStorage.saveToken("meu_jwt_seguro_123");
        return Success(unit);
      } else {
        return Failure(Exception("E-mail ou senha inválidos"));
      }
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  AsyncResult<Unit> register(RegisterModel registerModel) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      await _tokenStorage.saveToken("meu_jwt_seguro_123");
      return Success(unit);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  AsyncResult<Unit> forgotPassword(LoginModel loginModel) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      return Success(unit);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  AsyncResult<Unit> logout() async {
    await _tokenStorage.clear();
    return Success(unit);
  }
}
