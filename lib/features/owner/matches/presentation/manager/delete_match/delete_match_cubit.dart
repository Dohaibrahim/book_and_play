import 'dart:developer';

import 'package:book_and_play/features/owner/matches/domain/useacse/delete_match_usecase.dart';
import 'package:book_and_play/features/owner/matches/presentation/manager/delete_match/delete_match_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteMatchCubit extends Cubit<DeleteMatchState> {
  DeleteMatchCubit() : super(DeleteMatchInitialState());

  Future<void> deleteMatch(String matchId) async {
    emit(DeleteMatchLoadingState());
    final result = await DeleteMatchUsecase(matchId: matchId).call();
    result.fold(
      (failure) {
        log('error: ${failure.message}');
        emit(DeleteMatchFailureState(message: failure.message));
      },
      (data) {
        emit(DeleteMatchSuccessState(message: data));
      },
    );
  }
}
