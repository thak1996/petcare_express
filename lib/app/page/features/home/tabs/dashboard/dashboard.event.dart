import '../../../../../core/models/features/notification.model.dart';
import '../../../../../core/models/features/schedule.model.dart';

abstract class DashboardEvent {}

class LoadDashboardData extends DashboardEvent {}

class ToggleTask extends DashboardEvent {
  final ScheduleModel task;
  ToggleTask(this.task);
}

class DismissNotification extends DashboardEvent {
  final NotificationModel notification;
  DismissNotification(this.notification);
}

class TaskUpdatedExternal extends DashboardEvent {
  TaskUpdatedExternal(this.task);

  final ScheduleModel task;
}

class NotificationDismissedExternal extends DashboardEvent {
  final String notificationId;
  NotificationDismissedExternal(this.notificationId);
}
