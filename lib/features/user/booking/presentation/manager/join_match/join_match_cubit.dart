import 'dart:developer';

import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/features/user/booking/domain/repo/booking_repo.dart';
import 'package:book_and_play/features/user/booking/domain/usecase/join_match_usecase.dart';
import 'package:book_and_play/features/user/booking/presentation/manager/join_match/join_match_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JoinMatchCubit extends Cubit<JoinMatchState> {
  JoinMatchCubit() : super(JoinMatchInitialState());

  Future<void> joinMatch(String matchId) async {
    emit(JoinMatchLoadingState());
    var result =
        await JoinMatchUsecase(
          bookingRepo: getIt<BookingRepo>(),
          id: matchId,
        ).call();
    result.fold(
      (failue) {
        log('error in JoinMatchCubit ${failue.message}');
        emit(JoinMatchFailureState(errorMessage: failue.message));
      },
      (data) {
        emit(JoinMatchSuccessState(joinMatchModel: data.match));
      },
    );
  }
}
