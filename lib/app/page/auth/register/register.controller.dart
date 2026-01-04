import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petcare_express/app/core/models/login.model.dart';
import 'register.state.dart';

class RegisterController extends Cubit<RegisterState> {
  RegisterController() : super(const RegisterInitial());

  bool _acceptedTerms = false;

  bool get acceptedTerms => _acceptedTerms;

  void setAcceptedTerms(bool value) => _acceptedTerms = value;

  Future<void> register(LoginModel loginModel) async {
    try {
      emit(const RegisterLoading());
      if (!_acceptedTerms) {
        emit(const RegisterError('Você deve aceitar os termos e condições'));
        return;
      }
      log('email: ${loginModel.email}');
      log('password: ${loginModel.password}');
      log('name: ${loginModel.name}');
      emit(const RegisterSuccess());
    } catch (e) {
      emit(RegisterError(e.toString()));
    }
  }
}
