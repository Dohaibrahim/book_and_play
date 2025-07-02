abstract class DeleteMatchState {}

class DeleteMatchInitialState extends DeleteMatchState {}

class DeleteMatchLoadingState extends DeleteMatchState {}

class DeleteMatchSuccessState extends DeleteMatchState {
  final String message;
  DeleteMatchSuccessState({required this.message});
}

class DeleteMatchFailureState extends DeleteMatchState {
  final String message;
  DeleteMatchFailureState({required this.message});
}
