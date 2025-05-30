import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/features/owner/owner_fields/domain/usecase/owner_field_usecase.dart';
import 'package:book_and_play/features/owner/owner_fields/presentation/manager/owner_field_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OwnerFieldCubit extends Cubit<OwnerFieldState> {
  OwnerFieldCubit() : super(OwnerFieldInitialState());

  Future<void> getFields() async {
    emit(OwnerFieldLoadingState());
    var result = await getIt<OwnerFieldUsecase>().call();
    result.fold(
      (failure) {
        emit(OwnerFieldFailueState(errorMesage: failure.toString()));
      },
      (fields) {
        emit(OwnerFieldSuccessState(fields: fields));
      },
    );
  }
}
