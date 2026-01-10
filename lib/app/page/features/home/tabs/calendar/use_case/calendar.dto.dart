import 'package:petcare_express/app/core/models/features/notification.model.dart';
import 'package:petcare_express/app/core/models/features/pet.model.dart';
import 'package:petcare_express/app/core/models/features/schedule.model.dart';

class CalendarDataDto {
  final List<PetModel> pets;
  final List<ScheduleModel> tasks;
  final List<NotificationModel> notifications;

  CalendarDataDto({
    required this.pets,
    required this.tasks,
    required this.notifications,
  });
}
