import 'package:book_and_play/features/owner/tournament/data/models/tournaments_res.dart';

abstract class FetchTournamentsState {}

class FetchTournamentsInitialState extends FetchTournamentsState {}

class FetchTournamentsLoadingState extends FetchTournamentsState {}

class FetchTournamentsSuccessState extends FetchTournamentsState {
  final String message;
  final List<Tournament> tournament;
  FetchTournamentsSuccessState({
    required this.message,
    required this.tournament,
  });
}

class FetchTournamentsFailureState extends FetchTournamentsState {
  final String errorMsg;
  FetchTournamentsFailureState({required this.errorMsg});
}
