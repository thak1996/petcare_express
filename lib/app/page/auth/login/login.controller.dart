import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/login.model.dart';
import '../../../core/utils/secure_storage.dart';
import 'login.state.dart';

class LoginController extends Cubit<LoginState> {
  LoginController(this._secureStorageService) : super(const LoginInitial());

  // ignore: unused_field
  final SecureStorageService _secureStorageService;

  void validateFields(LoginModel credentials) {
    final newCredentials = LoginModel(
      email: credentials.email,
      password: credentials.password,
    );
    emit(
      LoginInitial(
        isValid: newCredentials.isValid,
        credentials: newCredentials,
      ),
    );
  }

  Future<void> login(LoginModel credentials) async {
    emit(LoginLoading(credentials: credentials));
    try {
      await Future.delayed(const Duration(seconds: 2));
      log('email: ${credentials.email}');
      emit(LoginSuccess(credentials: credentials));
    } catch (e) {
      emit(LoginError(e.toString(), credentials: credentials));
    }
  }
}
