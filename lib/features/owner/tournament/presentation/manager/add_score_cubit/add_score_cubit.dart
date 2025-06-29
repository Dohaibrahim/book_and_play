import 'dart:developer';

import 'package:book_and_play/features/owner/tournament/data/models/add_score_req.dart';
import 'package:book_and_play/features/owner/tournament/domain/usecase/add_score_usecase.dart';
import 'package:book_and_play/features/owner/tournament/presentation/manager/add_score_cubit/add_score_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddScoreCubit extends Cubit<AddScoreState> {
  AddScoreCubit() : super(AddScoreInitialState());

  Future<void> addScore(String matchId, AddScoreReq addScoreReq) async {
    emit(AddScoreLoadingState());
    try {
      final result = await AddScoreUsecase(id: matchId).call(addScoreReq);
      result.fold(
        (failure) {
          log("error : ${failure.message.toString()}");
          emit(AddScoreFailureState(msg: failure.message.toString()));
        },
        (data) {
          log("data : ${data.message}");
          emit(AddScoreSuccessState(match: data.match));
        },
      );
    } catch (e) {
      emit(AddScoreFailureState(msg: e.toString()));
    }
  }
}
