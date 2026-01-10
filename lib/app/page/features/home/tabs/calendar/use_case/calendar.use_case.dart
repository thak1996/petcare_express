import 'package:petcare_express/app/core/models/features/pet.model.dart';
import 'package:petcare_express/app/core/models/features/schedule.model.dart';
import 'package:petcare_express/app/core/models/features/notification.model.dart';
import 'package:petcare_express/app/core/repository/notification.repository.dart';
import 'package:petcare_express/app/core/repository/pet.repository.dart';
import 'package:petcare_express/app/core/repository/schedule.repository.dart';
import 'package:result_dart/result_dart.dart';
import 'calendar.dto.dart';

class CalendarUseCase {
  final IPetRepository _petRepo;
  final IScheduleRepository _scheduleRepo;
  final INotificationRepository _notificationRepo;

  CalendarUseCase(this._petRepo, this._scheduleRepo, this._notificationRepo);

  AsyncResult<CalendarDataDto> execute(String userId) async {
    try {
      final results = await Future.wait([
        _petRepo.getPetsForUser(userId),
        _scheduleRepo.getTodayTasks(userId),
        _notificationRepo.getNotifications(userId),
      ]);

      final petsResult = results[0] as Result<List<PetModel>>;
      final tasksResult = results[1] as Result<List<ScheduleModel>>;
      final notifResult = results[2] as Result<List<NotificationModel>>;

      final pets = petsResult.getOrDefault([]);
      final tasks = tasksResult.getOrDefault([]);
      final notifications = notifResult.getOrDefault([]);

      return Success(
        CalendarDataDto(pets: pets, tasks: tasks, notifications: notifications),
      );
    } catch (e) {
      return Failure(Exception("Erro ao processar dados da agenda: $e"));
    }
  }
}
