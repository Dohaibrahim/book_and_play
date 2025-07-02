abstract class ChangePassState {}

class ChangePassInitialState extends ChangePassState {}

class ChangePassLoadingState extends ChangePassState {}

class ChangePassSuccessState extends ChangePassState {
  final String message;
  ChangePassSuccessState({required this.message});
}

class ChangePassFailureState extends ChangePassState {
  final String errorMessage;
  ChangePassFailureState({required this.errorMessage});
}
