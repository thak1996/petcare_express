import '../../../../../core/models/features/schedule.model.dart';

abstract class CalendarEvent {}

class LoadCalendarData extends CalendarEvent {}

class ChangeSelectedDate extends CalendarEvent {
  ChangeSelectedDate(this.date);

  final DateTime date;
}

class FilterByPet extends CalendarEvent {
  FilterByPet(this.petId);

  final String? petId;
}

class ToggleCalendarTask extends CalendarEvent {
  ToggleCalendarTask(this.task);

  final ScheduleModel task;
}

class TaskUpdatedExternal extends CalendarEvent {
  TaskUpdatedExternal(this.task);

  final ScheduleModel task;
}

class NotificationDismissedExternal extends CalendarEvent {
  final String notificationId;
  NotificationDismissedExternal(this.notificationId);
}
