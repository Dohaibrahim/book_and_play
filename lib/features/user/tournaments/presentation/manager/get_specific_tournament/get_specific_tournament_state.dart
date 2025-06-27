import 'package:book_and_play/features/user/tournaments/data/models/tournament_details_res.dart';

abstract class GetSpecificTournamentState {}

class GetSpecificTournamentInitialState extends GetSpecificTournamentState {}

class GetSpecificTournamentLoadingState extends GetSpecificTournamentState {}

class GetSpecificTournamentSuccessState extends GetSpecificTournamentState {
  final Tournament tournament;
  GetSpecificTournamentSuccessState({required this.tournament});
}

class GetSpecificTournamentFailureState extends GetSpecificTournamentState {
  final String msg;
  GetSpecificTournamentFailureState({required this.msg});
}
