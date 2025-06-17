import 'dart:developer';

import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/features/owner/tournament/data/models/add_tournament_req.dart';
import 'package:book_and_play/features/owner/tournament/domain/usecase/add_tournament_usecase.dart';
import 'package:book_and_play/features/owner/tournament/presentation/manager/add_tounament_cubit/add_tournament_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTournamentCubit extends Cubit<AddTournamentState> {
  AddTournamentCubit() : super(AddTournamentInitialState());

  Future<void> addTournament({required AddTournamentReq request}) async {
    emit(AddTournamentLoadingState());
    try {
      final result = await getIt<AddTournamentUsecase>().call(request);
      result.fold(
        (failure) {
          log("error : ${failure.message.toString()}");
          emit(AddTournamentFailureState(message: failure.toString()));
        },
        (data) {
          log("data : ${data.message}");
          emit(AddTournamentSuccessState());
        },
      );
    } catch (e) {
      emit(AddTournamentFailureState(message: e.toString()));
    }
  }
}
