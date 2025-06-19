import 'dart:developer';

import 'package:book_and_play/features/owner/add_field/data/models/add_field_req.dart';
import 'package:book_and_play/features/owner/add_field/domain/usecase/add_field_usecase.dart';
import 'package:book_and_play/features/owner/add_field/presentation/manager/add_field_cubit/add_field_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddFieldCubit extends Cubit<AddFieldState> {
  AddFieldCubit() : super(AddFieldInitialState());

  Future<void> addField(AddFieldRequest addFieldReq) async {
    emit(AddFieldLoadingState());
    final result = await AddFieldUsecase().call(addFieldReq);
    result.fold(
      (failure) {
        log('failure : ${failure.message}');
        emit(AddFieldFailureState(errMsg: failure.message));
      },
      (data) {
        log('data');
        emit(AddFieldSuccessState(field: data.field, message: data.message));
      },
    );
  }
}
