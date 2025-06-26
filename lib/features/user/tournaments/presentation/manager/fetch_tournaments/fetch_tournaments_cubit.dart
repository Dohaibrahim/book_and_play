import 'dart:developer';

import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/features/user/tournaments/domain/usecase/fetch_tournaments_usecase.dart';
import 'package:book_and_play/features/user/tournaments/presentation/manager/fetch_tournaments/fetch_tournaments_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FetchTournamentsCubit extends Cubit<FetchTournamentsState> {
  FetchTournamentsCubit() : super(FetchTournamentsInitialState());

  Future<void> fetchTournaments() async {
    emit(FetchTournamentsLoadingState());

    final result = await getIt<UserFetchTournamentsUsecase>().call();
    result.fold(
      (failure) {
        log('error at ${failure.message}');
        emit(FetchTournamentsFailureState(errorMessage: failure.message));
      },
      (data) {
        emit(FetchTournamentsSuccessState(tournaments: data.tournaments));
      },
    );
  }
}
