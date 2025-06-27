import 'dart:developer';

import 'package:book_and_play/features/user/tournaments/domain/usecase/get_specific_tournament_usecase.dart';
import 'package:book_and_play/features/user/tournaments/presentation/manager/get_specific_tournament/get_specific_tournament_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetSpecificTournamentCubit extends Cubit<GetSpecificTournamentState> {
  GetSpecificTournamentCubit() : super(GetSpecificTournamentInitialState());

  Future<void> getTournament(String id) async {
    emit(GetSpecificTournamentLoadingState());
    final result = await GetSpecificTournamentUsecase(id: id).call();
    result.fold(
      (failure) {
        log('error in cubit : ${failure.message}');
        emit(GetSpecificTournamentFailureState(msg: failure.message));
      },
      (data) {
        emit(GetSpecificTournamentSuccessState(tournament: data.tournament));
      },
    );
  }
}
