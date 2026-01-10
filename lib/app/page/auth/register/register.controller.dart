import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petcare_express/app/core/models/auth/user.model.dart';
import '../../../core/repository/auth.repository.dart';
import 'register.event.dart';
import 'register.state.dart';

class RegisterController extends Bloc<RegisterEvent, RegisterState> {
  RegisterController(this._authRepository) : super(RegisterInitial()) {
    on<RegisterSubmitted>(_onRegister);
  }

  final IAuthRepository _authRepository;

  bool _acceptedTerms = false;

  bool get acceptedTerms => _acceptedTerms;

  void setAcceptedTerms(bool value) => _acceptedTerms = value;

  Future<void> _onRegister(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterLoading());
    if (!_acceptedTerms) {
      emit(const RegisterError('Você deve aceitar os termos e condições'));
      return;
    }
    final result = await _authRepository.register(event.userModel);
    result.fold(
      (onSuccess) => emit(RegisterSuccess()),
      (onFailure) => emit(RegisterError(onFailure.toString())),
    );
  }
}
