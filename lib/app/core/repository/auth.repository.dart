import 'package:petcare_express/app/core/service/firebase/firebase_auth.service.dart';
import 'package:result_dart/result_dart.dart';
import '../exceptions/auth.exception.dart';
import '../models/auth/user.model.dart';
import '../service/storage/token.storage.dart';

abstract class IAuthRepository {
  AsyncResult<Unit> loginWithEmail(UserModel loginModel);
  AsyncResult<Unit> register(UserModel registerModel);
  AsyncResult<Unit> forgotPassword(UserModel loginModel);
  AsyncResult<Unit> logout();
}

class AuthRepositoryImpl implements IAuthRepository {
  final ITokenStorage _tokenStorage;
  final IFirebaseAuthService _firebaseAuthService;

  AuthRepositoryImpl(this._tokenStorage, this._firebaseAuthService);

  @override
  AsyncResult<Unit> loginWithEmail(UserModel userModel) async {
    final result = await _firebaseAuthService.login(
      email: userModel.email ?? '',
      password: userModel.password ?? '',
    );
    return result.fold((user) async {
      await _tokenStorage.saveToken(user.token ?? '');
      return Success(unit);
    }, (error) => Failure(error));
  }

  @override
  AsyncResult<Unit> register(UserModel userModel) async {
    final result = await _firebaseAuthService.register(
      userModel.name,
      email: userModel.email ?? '',
      password: userModel.password ?? '',
    );
    return result.fold((user) async {
      await _tokenStorage.saveToken(user.token ?? '');
      return Success(unit);
    }, (error) => Failure(error));
  }

  @override
  AsyncResult<Unit> forgotPassword(UserModel userModel) async {
    return await _firebaseAuthService.forgotPassword(
      email: userModel.email ?? '',
    );
  }

  @override
  AsyncResult<Unit> logout() async {
    await _tokenStorage.clear();
    return Success(unit);
  }
}
