import 'package:book_and_play/features/user/booking/data/models/join_match_model.dart';

abstract class JoinMatchState {}

class JoinMatchInitialState extends JoinMatchState {}

class JoinMatchLoadingState extends JoinMatchState {}

class JoinMatchSuccessState extends JoinMatchState {
  final MatchBooked joinMatchModel;
  JoinMatchSuccessState({required this.joinMatchModel});
}

class JoinMatchFailureState extends JoinMatchState {
  final String errorMessage;
  JoinMatchFailureState({required this.errorMessage});
}
