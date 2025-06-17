import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/features/owner/tournament/domain/usecase/fetch_tournaments.dart';
import 'package:book_and_play/features/owner/tournament/presentation/manager/fetch_tournaments/ffetch_tournaments_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FetchTournamentsCubit extends Cubit<FetchTournamentsState> {
  FetchTournamentsCubit() : super(FetchTournamentsInitialState());

  Future<void> fetchAlltournaments() async {
    emit(FetchTournamentsLoadingState());
    var result = await getIt<FetchTournamentsUsecase>().call();
    result.fold(
      (error) {
        emit(FetchTournamentsFailureState(errorMsg: error.message));
      },
      (data) {
        emit(
          FetchTournamentsSuccessState(
            message: data.message,
            tournament: data.tournaments,
          ),
        );
      },
    );
  }
}
