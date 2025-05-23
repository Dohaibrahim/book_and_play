import 'package:book_and_play/features/user/booking/data/models/available_matches_model.dart';

abstract class GetAvailableMatchesState {}

class GetAvailableMatchesInitialState extends GetAvailableMatchesState {}

class GetAvailableMatchesLoadingState extends GetAvailableMatchesState {}

class GetAvailableMatchesSuccessState extends GetAvailableMatchesState {
  final List<MatchModel> matches;
  GetAvailableMatchesSuccessState({required this.matches});
}

class GetAvailableMatchesFailureState extends GetAvailableMatchesState {
  final String errorMessage;
  GetAvailableMatchesFailureState({required this.errorMessage});
}
