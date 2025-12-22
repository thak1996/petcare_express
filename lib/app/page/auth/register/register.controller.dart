import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'register.state.dart';

class RegisterController extends Cubit<RegisterState> {
  RegisterController() : super(const RegisterInitial());

  bool _acceptedTerms = false;

  bool get acceptedTerms => _acceptedTerms;

  void setAcceptedTerms(bool value) => _acceptedTerms = value;

  Future<void> register(String email, String password) async {
    try {
      emit(const RegisterLoading());
      if (!_acceptedTerms) {
        emit(const RegisterError('Você deve aceitar os termos e condições'));
        return;
      }
      log('email: $email');
      log('password: $password');
      emit(const RegisterSuccess());
    } catch (e) {
      emit(RegisterError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    reset();
    return super.close();
  }

  void reset() => emit(const RegisterInitial());
}
