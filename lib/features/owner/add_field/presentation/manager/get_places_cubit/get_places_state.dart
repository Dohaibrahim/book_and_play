import 'package:book_and_play/features/owner/add_field/data/models/places_res.dart';

abstract class GetPlacesState {}

class GetPlacesInitialState extends GetPlacesState {}

class GetPlacesLoadingState extends GetPlacesState {}

class GetPlacesSuccessState extends GetPlacesState {
  final List<Place> place;
  GetPlacesSuccessState({required this.place});
}

class GetPlacesFailureState extends GetPlacesState {
  final String errorMessage;
  GetPlacesFailureState({required this.errorMessage});
}
