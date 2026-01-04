import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/login.model.dart';
import '../../../core/service/storage/token.storage.dart';
import 'login.state.dart';

class LoginController extends Cubit<LoginState> {
  LoginController(this._secureStorageService) : super(const LoginInitial());

  // ignore: unused_field
  final ITokenStorage _secureStorageService;

  Future<void> login(LoginModel loginModel) async {
    emit(const LoginLoading());
    try {
      await Future.delayed(const Duration(seconds: 2));
      log('email: ${loginModel.email}');
      emit(const LoginSuccess());
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
}
