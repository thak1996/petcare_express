import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/auth/user.model.dart';
import '../../../core/repository/auth.repository.dart';
import 'forgot.event.dart';
import 'forgot.state.dart';

class ForgotBloc extends Bloc<ForgotEvent, ForgotState> {
  ForgotBloc(this._authRepository) : super(ForgotInitial()) {
    on<ForgotSubmitted>(_sendRecovery);
  }

  final IAuthRepository _authRepository;

  Future<void> _sendRecovery(
    ForgotSubmitted event,
    Emitter<ForgotState> emit,
  ) async {
    emit(ForgotLoading());
    final result = await _authRepository.forgotPassword(
      UserModel(email: event.email),
    );
    result.fold(
      (onSuccess) => emit(ForgotSuccess()),
      (onFailure) => emit(ForgotError(onFailure.toString())),
    );
  }
}
