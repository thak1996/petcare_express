import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/auth/user.model.dart';
import '../../../core/repository/auth.repository.dart';
import 'forgot.state.dart';

class ForgotController extends Cubit<ForgotState> {
  ForgotController(this._authRepository) : super(ForgotInitial());

  final IAuthRepository _authRepository;

  Future<void> sendRecovery(UserModel userModel) async {
    emit(ForgotLoading());
    final result = await _authRepository.forgotPassword(userModel);
    result.fold(
      (onSuccess) => emit(ForgotSuccess()),
      (onFailure) => emit(ForgotError(onFailure.toString())),
    );
  }
}
