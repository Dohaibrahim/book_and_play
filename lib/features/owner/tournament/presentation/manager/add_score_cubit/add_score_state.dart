import 'package:book_and_play/features/owner/tournament/data/models/add_score_res.dart';

abstract class AddScoreState {}

class AddScoreInitialState extends AddScoreState {}

class AddScoreLoadingState extends AddScoreState {}

class AddScoreFailureState extends AddScoreState {
  final String msg;
  AddScoreFailureState({required this.msg});
}

class AddScoreSuccessState extends AddScoreState {
  final AddScoreMatch match;
  AddScoreSuccessState({required this.match});
}
