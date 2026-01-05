abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {}

class HomeLoggedOut extends HomeState {}

class HomeError extends HomeState {
  HomeError(this.message);

  final String message;
}
