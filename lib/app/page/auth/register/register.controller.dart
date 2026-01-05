import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petcare_express/app/core/models/auth/login.model.dart';
import '../../../core/repository/auth.repository.dart';
import 'register.state.dart';

class RegisterController extends Cubit<RegisterState> {
  RegisterController(this._authRepository) : super(const RegisterInitial());

  final IAuthRepository _authRepository;

  bool _acceptedTerms = false;

  bool get acceptedTerms => _acceptedTerms;

  void setAcceptedTerms(bool value) => _acceptedTerms = value;

  Future<void> register(LoginModel loginModel) async {
    emit(const RegisterLoading());
    if (!_acceptedTerms) {
      emit(const RegisterError('Você deve aceitar os termos e condições'));
      return;
    }
    final result = await _authRepository.loginWithEmail(loginModel);
    result.fold(
      (onSuccess) => emit(const RegisterSuccess()),
      (onFailure) => emit(RegisterError(onFailure.toString())),
    );
  }
}
