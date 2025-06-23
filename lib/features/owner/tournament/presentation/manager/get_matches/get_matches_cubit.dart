import 'dart:developer';

import 'package:book_and_play/features/owner/tournament/domain/usecase/get_matches_usecaes.dart';
import 'package:book_and_play/features/owner/tournament/presentation/manager/get_matches/get_matches_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetMatchesCubit extends Cubit<GetMatchesState> {
  GetMatchesCubit() : super(GetMatchesInitialState());

  Future<void> getMatches(String id) async {
    emit(GetMatchesLoadingState());
    final result = await GetMatchesUsecaes(id: id).call();
    result.fold(
      (failure) {
        log('error at cuuubit : ${failure.message}');
        emit(GetMatchesFailureState(errorMsg: failure.message));
      },
      (data) {
        log('success');
        emit(
          GetMatchesSuccessState(
            rounds: data.rounds,
            tournamentId: data.tournamentId,
          ),
        );
      },
    );
  }
}
