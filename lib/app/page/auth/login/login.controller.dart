import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/auth/user.model.dart';
import '../../../core/repository/auth.repository.dart';
import 'login.state.dart';

class LoginController extends Cubit<LoginState> {
  LoginController(this._authRepository) : super(const LoginInitial());

  final IAuthRepository _authRepository;

  Future<void> login(UserModel userModel) async {
    emit(const LoginLoading());
    final result = await _authRepository.loginWithEmail(userModel);
    result.fold(
      (onSuccess) => emit(const LoginSuccess()),
      (onFailure) => emit(LoginError(onFailure.toString())),
    );
  }
}
