import 'dart:developer';

import 'package:book_and_play/features/owner/tournament/domain/usecase/start_tournament_usecase.dart';
import 'package:book_and_play/features/owner/tournament/presentation/manager/start_tournament_cubit/start_tournament_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartTournamentCubit extends Cubit<StartTournamentState> {
  StartTournamentCubit() : super(StartTournamentInitialState());

  Future<void> startTournament(String id) async {
    emit(StartTournamentLoadingState());
    final result = await StartTournamentUsecase(id: id).call();
    result.fold(
      (failure) {
        log(failure.message);
        emit(StartTournamentFailureState(errorMessage: failure.message));
      },
      (data) {
        log(data.message);
        emit(StartTournamentSuccessState(message: data.message));
      },
    );
  }
}
