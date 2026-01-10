import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/auth/user.model.dart';
import '../../../core/repository/auth.repository.dart';
import 'login.event.dart';
import 'login.state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this._authRepository) : super(LoginInitial()) {
    on<LoginSubmitted>(_onLogin);
  }

  final IAuthRepository _authRepository;

  Future<void> _onLogin(LoginSubmitted event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    final result = await _authRepository.loginWithEmail(
      UserModel(email: event.email, password: event.password),
    );
    result.fold(
      (user) => emit(LoginSuccess()),
      (error) => emit(LoginError(error.toString())),
    );
  }
}
