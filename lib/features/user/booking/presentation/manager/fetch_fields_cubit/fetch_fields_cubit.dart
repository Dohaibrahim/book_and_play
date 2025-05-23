import 'package:book_and_play/features/user/booking/domain/usecase/fetch_fields_usecase.dart';
import 'package:book_and_play/features/user/booking/presentation/manager/fetch_fields_cubit/fetch_fields_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FetchFieldsCubit extends Cubit<FetchFieldsState> {
  FetchFieldsCubit({required this.fetchFieldsUsecase})
    : super(FetchFieldsInitialState());

  final FetchFieldsUsecase fetchFieldsUsecase;

  Future<void> fetchFields() async {
    emit(FetchFieldsLoadingState());
    var result = await fetchFieldsUsecase.call();
    result.fold(
      (failure) {
        emit(FetchFieldsFailureState(errorMessage: failure.toString()));
      },
      (fields) {
        emit(FetchFieldsSuccessState(fields: fields));
      },
    );
  }
}
