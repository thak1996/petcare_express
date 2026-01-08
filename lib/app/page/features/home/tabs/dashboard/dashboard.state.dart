abstract class DashBoardTabState {
  const DashBoardTabState();

  List<Object?> get props => [];
}

class DashBoardTabInitial extends DashBoardTabState {}

class DashBoardTabLoading extends DashBoardTabState {}

class DashBoardTabSuccess extends DashBoardTabState {
  // futuramente: final List<PetModel> pets;

  const DashBoardTabSuccess({required this.userName});

  final String userName;

  @override
  List<Object?> get props => [userName];
}

class DashBoardTabError extends DashBoardTabState {
  const DashBoardTabError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
