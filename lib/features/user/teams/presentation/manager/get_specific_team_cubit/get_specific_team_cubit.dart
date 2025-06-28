import 'dart:developer';

import 'package:book_and_play/features/user/teams/domain/usecase/get_specific_team_usecase.dart';
import 'package:book_and_play/features/user/teams/presentation/manager/get_specific_team_cubit/get_specific_team_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetSpecificTeamCubit extends Cubit<GetSpecificTeamState> {
  GetSpecificTeamCubit() : super(GetSpecificTeamInitialState());

  Future<void> getTeam(String id) async {
    emit(GetSpecificTeamLoadingState());
    final result = await GetSpecificTeamUsecase(id: id).call();
    result.fold(
      (failure) {
        log('error at cubit : ${failure.message}');
        emit(GetSpecificTeamFailureState(errorMessage: failure.message));
      },
      (data) {
        emit(GetSpecificTeamSuccessState(team: data.team));
      },
    );
  }
}
