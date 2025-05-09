import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/features/auth/data/model/signup_req_params.dart';
import 'package:book_and_play/features/auth/data/model/signup_response.dart';
import 'package:book_and_play/features/auth/domain/usecase/signup_usecase.dart';
import 'package:book_and_play/features/auth/presentation/manager/signup_cubit/signup_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  static SignupCubit get(BuildContext context) => BlocProvider.of(context);

  void execute({
    required SignupReqParams params,
    required SignupUsecase usecase,
  }) async {
    emit(SignupLoading());

    try {
      final Either<Failure, SignupResponse> result = await usecase.call(params);

      result.fold(
        (error) {
          print('Signup error: ${error.message}'); // Log the error message
          emit(SignupFailure(errorMessage: error.message));
        },
        (data) {
          print('Signup successful: ${data.message}'); // Log success message
          emit(
            SignupSuccess(message: data.message),
          ); // Ensure you pass the user's name if available
        },
      );
    } catch (e) {
      print('Exception occurred: $e'); // Log the exception
      emit(SignupFailure(errorMessage: e.toString()));
    }
  }
}
