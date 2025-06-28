import 'package:book_and_play/features/user/teams/data/models/add_player_to_team_res.dart';

abstract class AddPlayerState {}

class AddPlayerInitialState extends AddPlayerState {}

class AddPlayerLoadingState extends AddPlayerState {}

class AddPlayerSuccessState extends AddPlayerState {
  final Team team;
  AddPlayerSuccessState({required this.team});
}

class AddPlayerFailureState extends AddPlayerState {
  final String message;
  AddPlayerFailureState({required this.message});
}
