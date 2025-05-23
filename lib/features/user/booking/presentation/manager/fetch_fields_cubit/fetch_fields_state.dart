import 'package:book_and_play/features/user/booking/data/models/all_fields_res.dart';

abstract class FetchFieldsState {}

class FetchFieldsInitialState extends FetchFieldsState {}

class FetchFieldsLoadingState extends FetchFieldsState {}

class FetchFieldsSuccessState extends FetchFieldsState {
  final List<Field> fields;
  FetchFieldsSuccessState({required this.fields});
}

class FetchFieldsFailureState extends FetchFieldsState {
  final String errorMessage;
  FetchFieldsFailureState({required this.errorMessage});
}
