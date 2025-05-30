import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/features/user/user_booking/domain/usecases/user_bookings_usecase.dart';
import 'package:book_and_play/features/user/user_booking/presentation/manager/user_bookings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class UserBookingsCubit extends Cubit<UserBookingsState> {
  UserBookingsCubit() : super(UserBookingsInitialState());

  Future<void> getUserMatches() async {
    emit(UserBookingsLoadingState());
    final result = await getIt<UserBookingsUsecase>().call();
    result.fold(
      (failure) {
        emit(UserBookingsFailureState(message: failure.message));
      },
      (matches) {
        emit(UserBookingsSuccessState(matches: matches.matches));
      },
    );
  }
}
