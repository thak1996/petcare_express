import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:result_dart/result_dart.dart';
import '../../../../../core/models/auth/user.model.dart';
import '../../../../../core/models/features/schedule.model.dart';
import '../../../../../core/models/features/notification.model.dart';
import '../../../../../core/repository/auth.repository.dart';
import '../../../../../core/repository/notification.repository.dart';
import '../../../../../core/repository/schedule.repository.dart';
import 'dashboard.event.dart';
import 'dashboard.state.dart';
import 'use_case/dashboard.use_case.dart';

class DashBoardBloc extends Bloc<DashboardEvent, DashBoardTabState> {
  DashBoardBloc(
    this._authRepository,
    this._dashboardUseCase,
    this._notificationRepo,
    this._scheduleRepository,
  ) : super(DashBoardTabInitial()) {
    on<LoadDashboardData>(_onLoadData);
    on<ToggleTask>(_onToggleTask);
    on<DismissNotification>(_onDismissNotification);
  }

  final IAuthRepository _authRepository;
  final DashboardUseCase _dashboardUseCase;
  final INotificationRepository _notificationRepo;
  final IScheduleRepository _scheduleRepository;

  Future<void> _onLoadData(
    LoadDashboardData event,
    Emitter<DashBoardTabState> emit,
  ) async {
    if (state is! DashBoardTabSuccess) emit(DashBoardTabLoading());

    final userResult = await _authRepository.getCurrentUser();
    if (userResult.isError()) {
      emit(DashBoardTabError(userResult.exceptionOrNull().toString()));
      return;
    }

    final user = userResult.getOrDefault(UserModel.empty());
    final result = await _dashboardUseCase.execute(user.id.toString());

    result.fold(
      (data) => emit(
        DashBoardTabSuccess(
          userName: user.name ?? 'Usuário',
          pets: data.pets,
          notifications: data.notifications,
          todayTasks: data.todayTasks,
        ),
      ),
      (error) => emit(DashBoardTabError(error.toString())),
    );
  }

  Future<void> _onToggleTask(
    ToggleTask event,
    Emitter<DashBoardTabState> emit,
  ) async {
    if (state is! DashBoardTabSuccess) return;
    final currentState = state as DashBoardTabSuccess;

    final updatedTasks = currentState.todayTasks.map((t) {
      return t.id == event.task.id ? t.copyWith(isDone: !t.isDone) : t;
    }).toList();

    emit(currentState.copyWith(todayTasks: updatedTasks));

    final result = await _scheduleRepository.updateTaskStatus(event.task.id);
    if (result.isError()) {
      add(LoadDashboardData());
    }
  }

  Future<void> _onDismissNotification(
    DismissNotification event,
    Emitter<DashBoardTabState> emit,
  ) async {
    if (state is! DashBoardTabSuccess) return;
    final currentState = state as DashBoardTabSuccess;

    final updatedNotifications = currentState.notifications
        .where((n) => n.id != event.notification.id)
        .toList();

    emit(currentState.copyWith(notifications: updatedNotifications));

    final result = await _notificationRepo.dismissNotification(
      event.notification.id,
    );
    if (result.isError()) {
      add(LoadDashboardData());
    }
  }
}
