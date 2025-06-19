import 'package:book_and_play/features/owner/add_field/data/models/field_creation_res.dart';

abstract class AddFieldState {}

class AddFieldInitialState extends AddFieldState {}

class AddFieldLoadingState extends AddFieldState {}

class AddFieldFailureState extends AddFieldState {
  final String errMsg;
  AddFieldFailureState({required this.errMsg});
}

class AddFieldSuccessState extends AddFieldState {
  final String message;
  final FieldCreated field;
  AddFieldSuccessState({required this.field, required this.message});
}
