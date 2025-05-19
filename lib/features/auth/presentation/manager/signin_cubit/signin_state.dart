import 'package:book_and_play/features/auth/data/model/signin_response.dart';

abstract class SigninState {}

class SigninInitialState extends SigninState {}

class SigninLoadingState extends SigninState {}

class SigninSuccessState extends SigninState {
  final String message;
  final String token, role;
  final User user;
  SigninSuccessState({
    required this.message,
    required this.token,
    required this.role,
    required this.user,
  });
}

class SigninFailureState extends SigninState {
  final String errorMessage;
  SigninFailureState({required this.errorMessage});
}
