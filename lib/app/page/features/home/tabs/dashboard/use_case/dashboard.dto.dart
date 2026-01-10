import '../../../../../../core/models/features/notification.model.dart';
import '../../../../../../core/models/features/pet.model.dart';
import '../../../../../../core/models/features/schedule.model.dart';

class DashboardDataDto {
  final List<PetModel> pets;
  final List<ScheduleModel> todayTasks;
  final List<NotificationModel> notifications;

  DashboardDataDto({
    required this.pets,
    required this.todayTasks,
    required this.notifications,
  });
}
