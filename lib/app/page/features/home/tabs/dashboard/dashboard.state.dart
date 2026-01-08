import '../../../../../core/models/features/notification.model.dart';
import '../../../../../core/models/features/pet.model.dart';

abstract class DashBoardTabState {
  const DashBoardTabState();

  List<Object?> get props => [];
}

class DashBoardTabInitial extends DashBoardTabState {}

class DashBoardTabLoading extends DashBoardTabState {}

class DashBoardTabSuccess extends DashBoardTabState {
  const DashBoardTabSuccess({
    required this.userName,
    required this.pets,
    required this.notifications,
  });

  final List<NotificationModel> notifications;
  final List<PetModel> pets;
  final String userName;

  @override
  List<Object?> get props => [userName, pets, notifications];
}

class DashBoardTabError extends DashBoardTabState {
  const DashBoardTabError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
