abstract class AddTournamentState {}

class AddTournamentInitialState extends AddTournamentState {}

class AddTournamentLoadingState extends AddTournamentState {}

class AddTournamentSuccessState extends AddTournamentState {}

class AddTournamentFailureState extends AddTournamentState {
  final String message;

  AddTournamentFailureState({required this.message});
}
