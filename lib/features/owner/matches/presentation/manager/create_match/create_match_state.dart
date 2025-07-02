abstract class CreateMatchState {}

class CreateMatchInitialState extends CreateMatchState {}

class CreateMatchLoadingState extends CreateMatchState {}

class CreateMatchFailureState extends CreateMatchState {
  final String errorMessage;
  CreateMatchFailureState({required this.errorMessage});
}

class CreateMatchSuccessState extends CreateMatchState {
  final String message;
  CreateMatchSuccessState({required this.message});
}
