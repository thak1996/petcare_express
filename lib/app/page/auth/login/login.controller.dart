import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/auth/user.model.dart';
import '../../../core/repository/auth.repository.dart';
import 'login.state.dart';

class LoginController extends Cubit<LoginState> {
  LoginController(this._authRepository) : super(LoginInitial());

  final IAuthRepository _authRepository;

  Future<void> login(UserModel userModel) async {
    emit(LoginLoading());
    final result = await _authRepository.loginWithEmail(userModel);
    result.fold(
      (onSuccess) => emit(LoginSuccess()),
      (onFailure) => emit(LoginError(onFailure.toString())),
    );
  }
}
