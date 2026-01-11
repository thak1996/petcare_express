import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petcare_express/app/page/features/home/tabs/calendar/use_case/calendar.use_case.dart';
import 'package:result_dart/result_dart.dart';
import '../../../../../core/models/features/pet.model.dart';
import '../../../../../core/models/features/schedule.model.dart';
import '../../../../../core/repository/auth.repository.dart';
import '../../../../../core/repository/pet.repository.dart';
import '../../../../../core/repository/schedule.repository.dart';
import '../../../../../core/repository/notification.repository.dart';
import 'calendar.event.dart';
import 'calendar.state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  CalendarBloc(
    this._authRepository,
    this._useCase,
    this._scheduleRepository,
    this._notificationRepo,
  ) : super(CalendarInitial()) {
    on<LoadCalendarData>(_onLoadData);
    on<ChangeSelectedDate>(_onChangeDate);
    on<FilterByPet>(_onFilterByPet);
    on<ToggleCalendarTask>(_onToggleTask);
    on<TaskUpdatedExternal>(_onTaskUpdatedExternal);
    on<NotificationDismissedExternal>(_onNotificationDismissedExternal);
    _subscription = _scheduleRepository.onTaskStatusChanged.listen(
      (taskId) => add(TaskUpdatedExternal(taskId)),
    );
    _notifSubscription = _notificationRepo.onNotificationDismissed.listen(
      (id) => add(NotificationDismissedExternal(id)),
    );
  }

  late final StreamSubscription<ScheduleModel> _subscription;
  late final StreamSubscription<String> _notifSubscription;

  final IAuthRepository _authRepository;
  final IScheduleRepository _scheduleRepository;
  final CalendarUseCase _useCase;
  final INotificationRepository _notificationRepo;

  Future<void> _onLoadData(
    LoadCalendarData event,
    Emitter<CalendarState> emit,
  ) async {
    emit(CalendarLoading());
    final userResult = await _authRepository.getCurrentUser();
    final user = userResult.getOrNull();
    if (user == null) {
      emit(const CalendarError("Usuário não encontrado"));
      return;
    }
    final result = await _useCase.execute(user.id.toString());
    result.fold(
      (data) => emit(
        CalendarSuccess(
          pets: data.pets,
          todayTasks: data.tasks,
          notifications: data.notifications,
          selectedDate: DateTime.now(),
          selectedPetId: null,
        ),
      ),
      (error) => emit(CalendarError(error.toString())),
    );
  }

  void _onNotificationDismissedExternal(
    NotificationDismissedExternal event,
    Emitter<CalendarState> emit,
  ) {
    if (state is! CalendarSuccess) return;
    final currentState = state as CalendarSuccess;
    final updatedList = currentState.notifications
        .where((n) => n.id != event.notificationId)
        .toList();

    emit(currentState.copyWith(notifications: updatedList));
  }

  void _onChangeDate(ChangeSelectedDate event, Emitter<CalendarState> emit) {
    if (state is! CalendarSuccess) return;
    final currentState = state as CalendarSuccess;
    emit(currentState.copyWith(selectedDate: event.date));
  }

  void _onFilterByPet(FilterByPet event, Emitter<CalendarState> emit) {
    if (state is! CalendarSuccess) return;
    final currentState = state as CalendarSuccess;
    final isSamePet = currentState.selectedPetId == event.petId;
    emit(
      currentState.copyWith(
        selectedPetId: event.petId,
        clearPetFilter: isSamePet || event.petId == null,
      ),
    );
  }

  Future<void> _onToggleTask(
    ToggleCalendarTask event,
    Emitter<CalendarState> emit,
  ) async {
    if (state is! CalendarSuccess) return;
    final currentState = state as CalendarSuccess;
    final newTasks = currentState.todayTasks.map((t) {
      return t.id == event.task.id ? t.copyWith(isDone: !t.isDone) : t;
    }).toList();
    emit(currentState.copyWith(todayTasks: newTasks));
    final result = await _scheduleRepository.updateTaskStatus(event.task.id);
    if (result.isError()) {
      add(LoadCalendarData());
    }
  }

  void _onTaskUpdatedExternal(
    TaskUpdatedExternal event,
    Emitter<CalendarState> emit,
  ) {
    if (state is! CalendarSuccess) return;
    final currentState = state as CalendarSuccess;
    final updatedTasks = currentState.todayTasks.map((task) {
      if (task.id == event.task.id) return event.task;
      return task;
    }).toList();
    emit(currentState.copyWith(todayTasks: updatedTasks));
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    _notifSubscription.cancel();
    return super.close();
  }
}
