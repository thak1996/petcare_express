import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/repository/auth.repository.dart';
import 'dashboard.state.dart';

class DashBoardTabController extends Cubit<DashBoardTabState> {
  DashBoardTabController(this._authRepository) : super(DashBoardTabInitial());

  final IAuthRepository _authRepository;

  Future<void> loadData() async {
    emit(DashBoardTabLoading());
    final userResult = await _authRepository.getCurrentUser();
    userResult.fold(
      (user) => emit(DashBoardTabSuccess(userName: user.name ?? 'UserName')),
      (error) => emit(DashBoardTabError(error.toString())),
    );
  }
}
