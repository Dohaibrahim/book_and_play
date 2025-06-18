import 'dart:developer';

import 'package:book_and_play/features/owner/tournament/domain/usecase/get_tournament_teams.dart';
import 'package:book_and_play/features/owner/tournament/presentation/manager/get_tournaments_teams/get_tournaments_teams_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetTournamentsTeamsCubit extends Cubit<GetTournamentsTeamsState> {
  GetTournamentsTeamsCubit() : super(GetTournamentsTeamsInitialState());

  Future<void> getTeams(String id) async {
    emit(GetTournamentsTeamsLoadingState());

    var result = await GetTournamentTeamsUsecase(id).call();
    result.fold(
      (error) {
        log('error : ${error.message}');
        emit(GetTournamentsTeamsFailureState(errorMessage: error.message));
      },
      (data) {
        log('success : ${data.message}');
        emit(GetTournamentsTeamsSuccessState(teams: data.tournament.teams));
      },
    );
  }
}
