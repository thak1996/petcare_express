import 'dart:async';
import 'package:result_dart/result_dart.dart';
import '../models/features/schedule.model.dart';

abstract class IScheduleRepository {
  AsyncResult<List<ScheduleModel>> getTodayTasks(String userId);
  AsyncResult<Unit> updateTaskStatus(String taskId);
  AsyncResult<Unit> addTaskForUser(String userId, ScheduleModel task);
  AsyncResult<Unit> removeTaskForUser(String userId, String taskId);
  AsyncResult<List<ScheduleModel>> getTasksByDate(
    String userId,
    DateTime date, {
    String? petId,
  });
  Stream<ScheduleModel> get onTaskStatusChanged;
}

class ScheduleRepositoryImpl implements IScheduleRepository {
  final List<ScheduleModel> _mockTasks = [
    ScheduleModel(
      id: '1',
      title: 'Vacina Antirrábica',
      time: '14:00',
      subtitle: 'Veterinário Central',
      type: TaskType.health,
      isDone: false,
      petId: 'pet1',
      petName: 'Rex',
    ),
    ScheduleModel(
      id: '2',
      title: 'Jantar do Rex',
      time: '18:30',
      subtitle: 'Ração Premium',
      type: TaskType.food,
      isDone: false,
      petId: 'pet1',
      petName: 'Rex',
    ),
    ScheduleModel(
      id: '3',
      title: 'Passeio Matinal',
      time: '08:15',
      subtitle: 'Parque da Cidade',
      type: TaskType.activity,
      isDone: true,
      petId: 'pet2',
      petName: 'Luna',
    ),
  ];

  final _statusChangeController = StreamController<ScheduleModel>.broadcast();

  @override
  AsyncResult<Unit> addTaskForUser(String userId, ScheduleModel task) async {
    _mockTasks.add(task);
    return Success(unit);
  }

  @override
  AsyncResult<List<ScheduleModel>> getTasksByDate(
    String userId,
    DateTime date, {
    String? petId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return Success(_mockTasks);
  }

  @override
  AsyncResult<List<ScheduleModel>> getTodayTasks(String userId) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return Success(_mockTasks);
  }

  @override
  Stream<ScheduleModel> get onTaskStatusChanged =>
      _statusChangeController.stream;

  @override
  AsyncResult<Unit> removeTaskForUser(String userId, String taskId) async {
    _mockTasks.removeWhere((task) => task.id == taskId);
    return Success(unit);
  }

  @override
  AsyncResult<Unit> updateTaskStatus(String taskId) async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      final index = _mockTasks.indexWhere((task) => task.id == taskId);
      if (index != -1) {
        final oldTask = _mockTasks[index];
        final newTask = oldTask.copyWith(isDone: !oldTask.isDone);
        _mockTasks[index] = newTask;
        _statusChangeController.add(newTask);
        return Success(unit);
      }
      return Failure(Exception("Tarefa não encontrada"));
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }
}
