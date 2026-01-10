import 'package:result_dart/result_dart.dart';
import '../../../../../../core/models/features/notification.model.dart';
import '../../../../../../core/models/features/pet.model.dart';
import '../../../../../../core/models/features/schedule.model.dart';
import '../../../../../../core/repository/notification.repository.dart';
import '../../../../../../core/repository/pet.repository.dart';
import '../../../../../../core/repository/schedule.repository.dart';
import 'dashboard.dto.dart';

class DashboardUseCase {
  final IPetRepository _petRepository;
  final IScheduleRepository _scheduleRepository;
  final INotificationRepository _notificationRepo;

  DashboardUseCase(
    this._petRepository,
    this._scheduleRepository,
    this._notificationRepo,
  );

  AsyncResult<DashboardDataDto> execute(String userId) async {
    try {
      final results = await Future.wait([
        _petRepository.getPetsForUser(userId),
        _scheduleRepository.getTodayTasks(userId),
        _notificationRepo.getNotifications(userId),
      ]);

      final petsResult = results[0] as Result<List<PetModel>>;
      final tasksResult = results[1] as Result<List<ScheduleModel>>;
      final notifResult = results[2] as Result<List<NotificationModel>>;

      return Success(DashboardDataDto(
        pets: petsResult.getOrDefault([]),
        todayTasks: tasksResult.getOrDefault([]),
        notifications: notifResult.getOrDefault([]),
      ));
    } catch (e) {
      return Failure(Exception("Erro ao carregar dashboard: $e"));
    }
  }
}