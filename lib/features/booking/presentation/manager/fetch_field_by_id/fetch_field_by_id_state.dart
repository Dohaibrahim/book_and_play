import 'package:book_and_play/features/booking/data/models/all_fields_res.dart';

abstract class FetchFieldByIdState {}

class FetchFieldByIdInitialState extends FetchFieldByIdState {}

class FetchFieldByIdLoadingState extends FetchFieldByIdState {}

class FetchFieldByIdSuccessState extends FetchFieldByIdState {
  final Field field;
  FetchFieldByIdSuccessState({required this.field});
}

class FetchFieldByIdFailureState extends FetchFieldByIdState {
  final String errorMsg;
  FetchFieldByIdFailureState({required this.errorMsg});
}
