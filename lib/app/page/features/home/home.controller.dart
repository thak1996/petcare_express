import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/repository/auth.repository.dart';
import 'home.state.dart';

class HomeController extends Cubit<HomeState> {
  HomeController(this._authRepository) : super(HomeInitial());

  final IAuthRepository _authRepository;

  Future<void> logout() async {
    emit(HomeLoading());
    final result = await _authRepository.logout();
    result.fold(
      (success) => emit(HomeLoggedOut()),
      (error) => emit(HomeError(error.toString())),
    );
  }
}
