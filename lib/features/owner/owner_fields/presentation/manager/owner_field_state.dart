import 'package:book_and_play/features/owner/owner_fields/data/models/owner_fields.dart';

abstract class OwnerFieldState {}

class OwnerFieldInitialState extends OwnerFieldState {}

class OwnerFieldLoadingState extends OwnerFieldState {}

class OwnerFieldSuccessState extends OwnerFieldState {
  final List<OwnerField> fields;
  OwnerFieldSuccessState({required this.fields});
}

class OwnerFieldFailueState extends OwnerFieldState {
  final String errorMesage;
  OwnerFieldFailueState({required this.errorMesage});
}
