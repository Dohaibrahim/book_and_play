import 'package:book_and_play/features/owner/owner_fields/domain/usecase/delete_field_usecase.dart';
import 'package:book_and_play/features/owner/owner_fields/presentation/manager/delete_field_cubit/delete_field_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteFieldCubit extends Cubit<DeleteFieldState> {
  DeleteFieldCubit() : super(DeleteFieldInitialState());

  Future<void> deleteField(String fieldId) async {
    emit(DeleteFieldLoadingState());
    var result = await DeleteFieldUsecase(fieldId: fieldId).call();
    result.fold(
      (failure) {
        emit(DeleteFieldFailureState(errorMessage: failure.message.toString()));
      },
      (fields) {
        emit(DeleteFieldSuccessState());
      },
    );
  }
}
