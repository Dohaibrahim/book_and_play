import 'dart:developer';

import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/features/user/booking/domain/repo/booking_repo.dart';
import 'package:book_and_play/features/user/booking/domain/usecase/get_available_matches.dart';
import 'package:book_and_play/features/user/booking/presentation/manager/get_available_matches/get_available_matches_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetAvailableMatchesCubit extends Cubit<GetAvailableMatchesState> {
  GetAvailableMatchesCubit({required this.fieldId})
    : super(GetAvailableMatchesInitialState());
  final String fieldId;

  Future<void> getAvailableMatches(String date) async {
    emit(GetAvailableMatchesLoadingState());
    var result =
        await GetAvailableMatchesUseCase(
          bookingRepo: getIt<BookingRepo>(),
          fieldId: fieldId,
          date: date,
        ).call();
    result.fold(
      (failue) {
        log('error in GetAvailableMatchesCubit ${failue.message}');
        emit(GetAvailableMatchesFailureState(errorMessage: failue.toString()));
      },
      (data) {
        emit(GetAvailableMatchesSuccessState(matches: data.matches));
      },
    );
  }
}
