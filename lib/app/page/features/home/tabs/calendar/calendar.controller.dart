import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petcare_express/app/page/features/home/tabs/calendar/use_case/calendar.use_case.dart';
import 'package:result_dart/result_dart.dart';
import '../../../../../core/models/features/pet.model.dart';
import '../../../../../core/models/features/schedule.model.dart';
import '../../../../../core/repository/auth.repository.dart';
import '../../../../../core/repository/pet.repository.dart';
import '../../../../../core/repository/schedule.repository.dart';
import 'calendar.state.dart';

class CalendarController extends Cubit<CalendarState> {
  CalendarController(
    this._authRepository,
    this._useCase,
    this._scheduleRepository,
  ) : super(CalendarInitial());

  final IAuthRepository _authRepository;
  final CalendarUseCase _useCase;
  final IScheduleRepository _scheduleRepository;

  Future<void> loadData() async {
    if (isClosed) return;
    emit(CalendarLoading());
    final userResult = await _authRepository.getCurrentUser();
    final user = userResult.getOrNull();
    if (user == null) {
      emit(const CalendarError("Usuário não encontrado"));
      return;
    }
    final result = await _useCase.execute(user.id.toString());
    result.fold(
      (data) {
        if (isClosed) return;
        emit(
          CalendarSuccess(
            pets: data.pets,
            todayTasks: data.tasks,
            notifications: data.notifications,
            selectedDate: DateTime.now(),
            selectedPetId: null,
          ),
        );
      },
      (error) {
        if (isClosed) return;
        emit(CalendarError(error.toString()));
      },
    );
  }

  void changeDate(DateTime date) {
    if (state is! CalendarSuccess) return;
    final currentState = state as CalendarSuccess;
    emit(currentState.copyWith(selectedDate: date));
  }

  void filterByPet(String? petId) {
    if (state is! CalendarSuccess) return;
    final currentState = state as CalendarSuccess;
    emit(currentState.copyWith(selectedPetId: petId));
  }

  Future<void> toggleTask(ScheduleModel task) async {
    if (state is! CalendarSuccess) return;
    final currentState = state as CalendarSuccess;
    final newTasks = currentState.todayTasks.map((t) {
      return t.id == task.id ? task.copyWith(isDone: !task.isDone) : t;
    }).toList();
    emit(currentState.copyWith(todayTasks: newTasks));
    final result = await _scheduleRepository.updateTaskStatus(task.id);
    if (result.isError()) loadData();
  }
}
