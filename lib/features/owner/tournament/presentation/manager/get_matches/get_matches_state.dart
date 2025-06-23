import 'package:book_and_play/features/owner/tournament/data/models/teams_matches_res.dart';

abstract class GetMatchesState {}

class GetMatchesInitialState extends GetMatchesState {}

class GetMatchesLoadingState extends GetMatchesState {}

class GetMatchesSuccessState extends GetMatchesState {
  final String tournamentId;
  final Rounds rounds;
  GetMatchesSuccessState({required this.rounds, required this.tournamentId});
}

class GetMatchesFailureState extends GetMatchesState {
  final String errorMsg;
  GetMatchesFailureState({required this.errorMsg});
}
