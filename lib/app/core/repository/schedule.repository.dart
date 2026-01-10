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
  @override
  AsyncResult<List<ScheduleModel>> getTodayTasks(String userId) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return Success(_mockTasks);
  }

  @override
  AsyncResult<Unit> updateTaskStatus(String taskId) async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      final index = _mockTasks.indexWhere((task) => task.id == taskId);
      if (index != -1) {
        final task = _mockTasks[index];
        _mockTasks[index] = ScheduleModel(
          id: task.id,
          title: task.title,
          time: task.time,
          subtitle: task.subtitle,
          type: task.type,
          isDone: !task.isDone,
          petId: task.petId,
          petName: task.petName,
        );
        return Success(unit);
      }
      return Failure(Exception("Tarefa não encontrada"));
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }

  @override
  AsyncResult<Unit> addTaskForUser(String userId, ScheduleModel task) async {
    _mockTasks.add(task);
    return Success(unit);
  }

  @override
  AsyncResult<Unit> removeTaskForUser(String userId, String taskId) async {
    _mockTasks.removeWhere((task) => task.id == taskId);
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
}
