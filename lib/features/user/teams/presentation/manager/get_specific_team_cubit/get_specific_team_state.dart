import 'package:book_and_play/features/user/teams/data/models/specific_team_res.dart';

abstract class GetSpecificTeamState {}

class GetSpecificTeamInitialState extends GetSpecificTeamState {}

class GetSpecificTeamLoadingState extends GetSpecificTeamState {}

class GetSpecificTeamFailureState extends GetSpecificTeamState {
  final String errorMessage;
  GetSpecificTeamFailureState({required this.errorMessage});
}

class GetSpecificTeamSuccessState extends GetSpecificTeamState {
  final SpecificTeam team;
  GetSpecificTeamSuccessState({required this.team});
}
