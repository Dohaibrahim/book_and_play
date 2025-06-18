import 'package:book_and_play/features/owner/tournament/data/models/get_spec_tournament_response.dart';

abstract class GetTournamentsTeamsState {}

class GetTournamentsTeamsInitialState extends GetTournamentsTeamsState {}

class GetTournamentsTeamsLoadingState extends GetTournamentsTeamsState {}

class GetTournamentsTeamsSuccessState extends GetTournamentsTeamsState {
  final List<Team> teams;
  GetTournamentsTeamsSuccessState({required this.teams});
}

class GetTournamentsTeamsFailureState extends GetTournamentsTeamsState {
  final String errorMessage;
  GetTournamentsTeamsFailureState({required this.errorMessage});
}
