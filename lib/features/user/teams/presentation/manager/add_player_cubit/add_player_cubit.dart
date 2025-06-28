import 'dart:developer';

import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/features/user/teams/data/models/add_player_to_team_req.dart';
import 'package:book_and_play/features/user/teams/domain/usecase/add_player_usecase.dart';
import 'package:book_and_play/features/user/teams/presentation/manager/add_player_cubit/add_player_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPlayerCubit extends Cubit<AddPlayerState> {
  AddPlayerCubit() : super(AddPlayerInitialState());

  Future<void> addPlayer(AddPlayerToTeamReq addPlayerTeamReq) async {
    emit(AddPlayerLoadingState());

    final result = await getIt<AddPlayerUsecase>().call(addPlayerTeamReq);
    result.fold(
      (failure) {
        log('error at cubit : ${failure.message}');
        emit(AddPlayerFailureState(message: failure.message));
      },
      (data) {
        emit(AddPlayerSuccessState(team: data.team));
      },
    );
  }
}
