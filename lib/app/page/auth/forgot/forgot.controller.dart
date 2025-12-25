import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'forgot.state.dart';

class ForgotController extends Cubit<ForgotState> {
  ForgotController() : super(const ForgotInitial());

  Future<void> sendRecovery(String email) async {
    try {
      emit(const ForgotLoading());
      await Future.delayed(const Duration(seconds: 2));
      log('recovery email: $email');
      emit(const ForgotSuccess());
    } catch (e) {
      emit(ForgotError(e.toString()));
    }
  }

  void reset() => emit(const ForgotInitial());
}
