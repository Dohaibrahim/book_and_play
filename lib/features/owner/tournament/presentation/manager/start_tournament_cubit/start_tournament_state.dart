abstract class StartTournamentState {}

class StartTournamentInitialState extends StartTournamentState {}

class StartTournamentLoadingState extends StartTournamentState {}

class StartTournamentSuccessState extends StartTournamentState {
  final String message;
  StartTournamentSuccessState({required this.message});
}

class StartTournamentFailureState extends StartTournamentState {
  final String errorMessage;
  StartTournamentFailureState({required this.errorMessage});
}
