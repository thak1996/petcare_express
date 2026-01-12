import 'dart:async';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:result_dart/result_dart.dart';
import '../database/hive_config.dart';
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
  final Box<ScheduleModel> _box = Hive.box<ScheduleModel>(
    HiveConfig.scheduleBoxName,
  );

  final _statusChangeController = StreamController<ScheduleModel>.broadcast();

  @override
  Stream<ScheduleModel> get onTaskStatusChanged =>
      _statusChangeController.stream;

  @override
  AsyncResult<Unit> addTaskForUser(String userId, ScheduleModel task) async {
    try {
      await _box.put(task.id, task);
      return Success(unit);
    } catch (e) {
      return Failure(Exception("Erro ao adicionar tarefa: $e"));
    }
  }

  @override
  AsyncResult<Unit> removeTaskForUser(String userId, String taskId) async {
    try {
      await _box.delete(taskId);
      return Success(unit);
    } catch (e) {
      return Failure(Exception("Erro ao remover tarefa: $e"));
    }
  }

  @override
  AsyncResult<List<ScheduleModel>> getTodayTasks(String userId) {
    return getTasksByDate(userId, DateTime.now());
  }

  @override
  AsyncResult<List<ScheduleModel>> getTasksByDate(
    String userId,
    DateTime date, {
    String? petId,
  }) async {
    try {
      final tasks = _box.values.where((task) {
        final taskDate = task.date;
        final isSameDate =
            taskDate.year == date.year &&
            taskDate.month == date.month &&
            taskDate.day == date.day;
        if (!isSameDate) return false;
        if (petId != null && task.petId != petId) {
          return false;
        }

        return true;
      }).toList();

      return Success(tasks);
    } catch (e) {
      return Failure(Exception("Erro ao buscar tarefas: $e"));
    }
  }

  @override
  AsyncResult<Unit> updateTaskStatus(String taskId) async {
    try {
      final task = _box.get(taskId);
      if (task != null) {
        final newTask = task.copyWith(isDone: !task.isDone);
        await _box.put(taskId, newTask);
        _statusChangeController.add(newTask);
        return Success(unit);
      }
      return Failure(Exception("Tarefa não encontrada"));
    } catch (e) {
      return Failure(Exception("Erro ao atualizar status: $e"));
    }
  }
}
