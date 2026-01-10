import '../../../../../core/models/features/notification.model.dart';
import '../../../../../core/models/features/pet.model.dart';
import '../../../../../core/models/features/schedule.model.dart';
import 'package:equatable/equatable.dart';

sealed class DashBoardTabState extends Equatable {
  const DashBoardTabState();

  @override
  List<Object?> get props => [];
}

final class DashBoardTabInitial extends DashBoardTabState {}

final class DashBoardTabLoading extends DashBoardTabState {}

final class DashBoardTabSuccess extends DashBoardTabState {
  const DashBoardTabSuccess({
    required this.userName,
    required this.pets,
    required this.notifications,
    required this.todayTasks,
  });

  final List<NotificationModel> notifications;
  final List<PetModel> pets;
  final List<ScheduleModel> todayTasks;
  final String userName;

  DashBoardTabSuccess copyWith({
    String? userName,
    List<PetModel>? pets,
    List<NotificationModel>? notifications,
    List<ScheduleModel>? todayTasks,
  }) {
    return DashBoardTabSuccess(
      userName: userName ?? this.userName,
      pets: pets ?? this.pets,
      notifications: notifications ?? this.notifications,
      todayTasks: todayTasks ?? this.todayTasks,
    );
  }

  @override
  List<Object?> get props => [userName, pets, notifications, todayTasks];
}

final class DashBoardTabError extends DashBoardTabState {
  const DashBoardTabError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
