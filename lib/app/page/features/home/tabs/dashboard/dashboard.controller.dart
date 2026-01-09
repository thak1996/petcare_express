import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:result_dart/result_dart.dart';
import '../../../../../core/models/auth/user.model.dart';
import '../../../../../core/models/features/notification.model.dart';
import '../../../../../core/models/features/pet.model.dart';
import '../../../../../core/models/features/schedule.model.dart';
import '../../../../../core/repository/auth.repository.dart';
import '../../../../../core/repository/notification.repository.dart';
import '../../../../../core/repository/pet.repository.dart';
import '../../../../../core/repository/schedule.repository.dart';
import 'dashboard.state.dart';

class DashBoardTabController extends Cubit<DashBoardTabState> {
  DashBoardTabController(
    this._authRepository,
    this._petRepository,
    this._notificationRepo,
    this._scheduleRepository,
  ) : super(DashBoardTabInitial());

  final IAuthRepository _authRepository;
  final IPetRepository _petRepository;
  final INotificationRepository _notificationRepo;
  final IScheduleRepository _scheduleRepository;

  Future<void> loadData() async {
    if (isClosed) return;
    if (state is! DashBoardTabSuccess) emit(DashBoardTabLoading());
    final userResult = await _authRepository.getCurrentUser();
    if (userResult.isError()) {
      emit(DashBoardTabError(userResult.exceptionOrNull().toString()));
      return;
    }
    final user = userResult.getOrDefault(UserModel.empty());
    final userId = user.id;
    final [notificationResult, petsResult, scheduleResult] = await Future.wait([
      _notificationRepo.getNotifications(userId.toString()),
      _petRepository.getPetsForUser(userId.toString()),
      _scheduleRepository.getTodayTasks(userId.toString()),
    ]);
    if (isClosed) return;
    if (notificationResult.isError() ||
        petsResult.isError() ||
        scheduleResult.isError()) {
      final errorMsg =
          notificationResult.exceptionOrNull()?.toString() ??
          petsResult.exceptionOrNull()?.toString() ??
          scheduleResult.exceptionOrNull()?.toString() ??
          "Erro ao carregar dados";
      emit(DashBoardTabError(errorMsg));
      return;
    }
    emit(
      DashBoardTabSuccess(
        userName: user.name ?? 'Usuário',
        pets: petsResult.getOrDefault(<PetModel>[]).cast<PetModel>(),
        notifications: notificationResult
            .getOrDefault(<NotificationModel>[])
            .cast<NotificationModel>(),
        todayTasks: scheduleResult
            .getOrDefault(<ScheduleModel>[])
            .cast<ScheduleModel>(),
      ),
    );
  }

  Future<void> toggleTask(ScheduleModel task) async {
    if (isClosed || state is! DashBoardTabSuccess) return;
    final currentState = state as DashBoardTabSuccess;
    final updatedTasks = currentState.todayTasks.map((t) {
      return t.id == task.id
          ? ScheduleModel(
              id: t.id,
              title: t.title,
              time: t.time,
              subtitle: t.subtitle,
              type: t.type,
              isDone: !t.isDone,
              petId: t.petId,
              petName: t.petName,
            )
          : t;
    }).toList();
    emit(currentState.copyWith(todayTasks: updatedTasks));
    final result = await _scheduleRepository.updateTaskStatus(task.id);
    if (result.isError()) {
      emit(DashBoardTabError("Não foi possível atualizar a tarefa"));
      loadData();
    }
  }

  Future<void> dismissNotification(NotificationModel notification) async {
    if (isClosed || state is! DashBoardTabSuccess) return;
    final currentState = state as DashBoardTabSuccess;
    final updatedNotifications = currentState.notifications
        .where((n) => n.id != notification.id)
        .toList();
    emit(currentState.copyWith(notifications: updatedNotifications));
    final result = await _notificationRepo.dismissNotification(notification.id);
    if (result.isError()) {
      loadData();
    }
  }
}
