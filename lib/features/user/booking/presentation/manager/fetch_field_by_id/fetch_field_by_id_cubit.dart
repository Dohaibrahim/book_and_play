import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/features/user/booking/domain/repo/booking_repo.dart';
import 'package:book_and_play/features/user/booking/domain/usecase/get_field_by_id_usecase.dart';
import 'package:book_and_play/features/user/booking/presentation/manager/fetch_field_by_id/fetch_field_by_id_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FetchFieldByIdCubit extends Cubit<FetchFieldByIdState> {
  FetchFieldByIdCubit({required this.fieldId})
    : super(FetchFieldByIdInitialState());
  final String? fieldId;
  Future<void> getFieldById() async {
    emit(FetchFieldByIdLoadingState());
    var result =
        await GetFieldByIdUsecase(
          bookingRepo: getIt<BookingRepo>(),
          id: fieldId ?? '',
        ).call();
    result.fold(
      (failure) {
        emit(FetchFieldByIdFailureState(errorMsg: failure.toString()));
      },
      (field) {
        emit(FetchFieldByIdSuccessState(field: field));
      },
    );
  }
}
