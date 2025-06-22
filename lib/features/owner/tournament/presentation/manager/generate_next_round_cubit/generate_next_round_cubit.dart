import 'dart:developer';

import 'package:book_and_play/features/owner/tournament/data/models/generate_next_round_req.dart';
import 'package:book_and_play/features/owner/tournament/domain/usecase/generate_next_round_usecase.dart';
import 'package:book_and_play/features/owner/tournament/presentation/manager/generate_next_round_cubit/generate_next_round_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GenerateNextRoundCubit extends Cubit<GenerateNextRoundState> {
  GenerateNextRoundCubit() : super(GenerateNextRoundInitialState());

  Future<void> generateRound(String id, NextRoundReq nextRoundReq) async {
    emit(GenerateNextRoundLoadingState());
    final result = await GenerateNextRoundUsecase(id: id).call(nextRoundReq);
    result.fold(
      (failure) {
        log('at cuuubit : ${failure.message}');
        emit(GenerateNextRoundFailureState(errorMessage: failure.message));
      },
      (data) {
        log(data.message);
        log("at cubitttt : ");
        emit(GenerateNextRoundSuccessState(message: data.message));
      },
    );
  }
}
