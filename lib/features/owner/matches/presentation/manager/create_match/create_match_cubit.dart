import 'dart:developer';

import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/features/owner/matches/data/models/create_match_req.dart';
import 'package:book_and_play/features/owner/matches/domain/useacse/create_match_usecase.dart';
import 'package:book_and_play/features/owner/matches/presentation/manager/create_match/create_match_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateMatchCubit extends Cubit<CreateMatchState> {
  CreateMatchCubit() : super(CreateMatchInitialState());

  Future<void> createMatch(CreateMatchReq createReq) async {
    emit(CreateMatchLoadingState());
    final result = await getIt<CreateMatchUsecase>().call(createReq);
    result.fold(
      (failure) {
        log('error : ${failure.message}');
        emit(CreateMatchFailureState(errorMessage: failure.message));
      },
      (data) {
        emit(CreateMatchSuccessState(message: data.message));
      },
    );
  }
}
