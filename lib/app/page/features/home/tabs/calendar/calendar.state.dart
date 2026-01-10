import 'package:equatable/equatable.dart';
import '../../../../../core/models/features/notification.model.dart';
import '../../../../../core/models/features/pet.model.dart';
import '../../../../../core/models/features/schedule.model.dart';

sealed class CalendarState extends Equatable {
  const CalendarState();

  @override
  List<Object?> get props => [];
}

final class CalendarInitial extends CalendarState {}

final class CalendarLoading extends CalendarState {}

final class CalendarSuccess extends CalendarState {
  final String? selectedPetId;
  final DateTime selectedDate;
  final List<PetModel> pets;
  final List<NotificationModel> notifications;
  final List<ScheduleModel> todayTasks;

  const CalendarSuccess({
    required this.todayTasks,
    required this.pets,
    required this.selectedDate,
    required this.notifications,
    this.selectedPetId,
  });

  CalendarSuccess copyWith({
    String? selectedPetId,
    DateTime? selectedDate,
    List<NotificationModel>? notifications,
    List<PetModel>? pets,
    List<ScheduleModel>? todayTasks,
    bool clearPetFilter = false,
  }) {
    return CalendarSuccess(
      selectedPetId: clearPetFilter
          ? null
          : (selectedPetId ?? this.selectedPetId),
      selectedDate: selectedDate ?? this.selectedDate,
      notifications: notifications ?? this.notifications,
      pets: pets ?? this.pets,
      todayTasks: todayTasks ?? this.todayTasks,
    );
  }

  @override
  List<Object?> get props => [
    selectedPetId,
    selectedDate,
    pets,
    notifications,
    todayTasks,
  ];
}

final class CalendarError extends CalendarState {
  final String message;
  const CalendarError(this.message);

  @override
  List<Object?> get props => [message];
}
