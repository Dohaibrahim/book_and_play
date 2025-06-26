import 'package:book_and_play/features/user/tournaments/data/models/get_tournaments_res.dart';

abstract class FetchTournamentsState {}

class FetchTournamentsInitialState extends FetchTournamentsState {}

class FetchTournamentsLoadingState extends FetchTournamentsState {}

class FetchTournamentsSuccessState extends FetchTournamentsState {
  final List<Tournament> tournaments;
  FetchTournamentsSuccessState({required this.tournaments});
}

class FetchTournamentsFailureState extends FetchTournamentsState {
  final String errorMessage;
  FetchTournamentsFailureState({required this.errorMessage});
}
