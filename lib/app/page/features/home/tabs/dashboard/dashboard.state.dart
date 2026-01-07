abstract class DashBoardTabState {
  const DashBoardTabState();
  List<Object?> get props => [];
}

class DashBoardTabInitial extends DashBoardTabState {}

class DashBoardTabLoading extends DashBoardTabState {}

class DashBoardTabSuccess extends DashBoardTabState {
  final String userName;
  // futuramente: final List<PetModel> pets;

  const DashBoardTabSuccess({required this.userName});
  @override
  List<Object?> get props => [userName];
}

class DashBoardTabError extends DashBoardTabState {
  final String message;
  const DashBoardTabError(this.message);

  @override
  List<Object?> get props => [message];
}
