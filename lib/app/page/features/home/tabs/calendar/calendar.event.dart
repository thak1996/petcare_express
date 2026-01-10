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
