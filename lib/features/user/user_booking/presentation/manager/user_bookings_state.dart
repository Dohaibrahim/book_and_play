import 'package:book_and_play/features/user/user_booking/data/models/user_matches_res.dart';

abstract class UserBookingsState {}

class UserBookingsInitialState extends UserBookingsState {}

class UserBookingsLoadingState extends UserBookingsState {}

class UserBookingsSuccessState extends UserBookingsState {
  final List<UserMatchModel> matches;
  UserBookingsSuccessState({required this.matches});
}

class UserBookingsFailureState extends UserBookingsState {
  final String message;
  UserBookingsFailureState({required this.message});
}
