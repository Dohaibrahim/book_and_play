import 'package:book_and_play/features/user/teams/data/models/team_create_res.dart';

abstract class PlayerTeamState {}

class PlayerTeamInitialState extends PlayerTeamState {}

class PlayerTeamLoadingState extends PlayerTeamState {}

class PlayerTeamSuccessState extends PlayerTeamState {
  final PlayerTeam team;
  PlayerTeamSuccessState({required this.team});
}

class PlayerTeamFailureState extends PlayerTeamState {
  final String message;
  PlayerTeamFailureState({required this.message});
}
