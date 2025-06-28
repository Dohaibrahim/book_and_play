import 'dart:developer';

import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/features/user/teams/data/models/team_create_req.dart';
import 'package:book_and_play/features/user/teams/domain/usecase/creat_team_usecase.dart';
import 'package:book_and_play/features/user/teams/presentation/manager/player_team_cubit/player_team_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayerTeamCubit extends Cubit<PlayerTeamState> {
  PlayerTeamCubit() : super(PlayerTeamInitialState());

  Future<void> createTeam(CreateTeamRequest createTeamReq) async {
    emit(PlayerTeamLoadingState());
    final result = await getIt<CreatTeamUsecase>().call(createTeamReq);
    result.fold(
      (failure) {
        log('fail : ${failure.message}');
        emit(PlayerTeamFailureState(message: failure.message));
      },
      (data) {
        emit(PlayerTeamSuccessState(team: data.team));
      },
    );
  }
}
