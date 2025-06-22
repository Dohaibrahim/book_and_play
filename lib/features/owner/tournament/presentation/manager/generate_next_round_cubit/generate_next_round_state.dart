abstract class GenerateNextRoundState {}

class GenerateNextRoundInitialState extends GenerateNextRoundState {}

class GenerateNextRoundLoadingState extends GenerateNextRoundState {}

class GenerateNextRoundSuccessState extends GenerateNextRoundState {
  final String message;
  GenerateNextRoundSuccessState({required this.message});
}

class GenerateNextRoundFailureState extends GenerateNextRoundState {
  final String errorMessage;
  GenerateNextRoundFailureState({required this.errorMessage});
}
