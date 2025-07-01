abstract class DeleteFieldState {}

class DeleteFieldInitialState extends DeleteFieldState {}

class DeleteFieldLoadingState extends DeleteFieldState {}

class DeleteFieldSuccessState extends DeleteFieldState {}

class DeleteFieldFailureState extends DeleteFieldState {
  final String errorMessage;
  DeleteFieldFailureState({required this.errorMessage});
}
