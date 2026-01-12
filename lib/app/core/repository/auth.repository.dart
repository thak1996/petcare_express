import 'dart:developer';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:result_dart/result_dart.dart';
import '../database/hive_config.dart';
import '../models/auth/user.model.dart';
import '../service/firebase/firebase_auth.service.dart';
import '../service/storage/token.storage.dart';

abstract class IAuthRepository {
  AsyncResult<Unit> loginWithEmail(UserModel loginModel);
  AsyncResult<Unit> register(UserModel registerModel);
  AsyncResult<Unit> forgotPassword(UserModel loginModel);
  AsyncResult<UserModel> getCurrentUser();
  AsyncResult<Unit> logout();
}

class AuthRepositoryImpl implements IAuthRepository {
  final ITokenStorage _tokenStorage;
  final IFirebaseAuthService _firebaseAuthService;

  final Box<UserModel> _userBox = Hive.box<UserModel>(HiveConfig.userBoxName);

  AuthRepositoryImpl(this._tokenStorage, this._firebaseAuthService);

  @override
  AsyncResult<Unit> loginWithEmail(UserModel userModel) async {
    final result = await _firebaseAuthService.login(
      email: userModel.email ?? '',
      password: userModel.password ?? '',
    );

    return result.fold((user) async {
      await _tokenStorage.saveToken(user.token ?? '');
      await _userBox.put('current_user', user);
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
      await _userBox.put('current_user', user);
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
    await _userBox.delete('current_user');
    return Success(unit);
  }

  @override
  AsyncResult<UserModel> getCurrentUser() async {
    try {
      final cachedUser = _userBox.get('current_user');
      if (cachedUser != null) {
        _refreshUserCache();
        return Success(cachedUser);
      }
      final result = await _firebaseAuthService.getCurrentUser();
      return result.fold((user) {
        _userBox.put('current_user', user);
        return Success(user);
      }, (error) => Failure(error));
    } catch (e) {
      return _firebaseAuthService.getCurrentUser();
    }
  }

  void _refreshUserCache() async {
    final result = await _firebaseAuthService.getCurrentUser();
    result.fold((user) async {
      await _userBox.put('current_user', user);
    }, (error) => log('Erro ao atualizar cache de usuário: $error'));
  }
}
