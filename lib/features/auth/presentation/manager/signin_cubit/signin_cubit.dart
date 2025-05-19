import 'dart:developer';

import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/core/utils/api_service.dart';
import 'package:book_and_play/core/utils/constant.dart';
import 'package:book_and_play/core/utils/shared_pref.dart';
import 'package:book_and_play/features/auth/data/model/signin_req_params.dart';
import 'package:book_and_play/features/auth/data/model/signin_response.dart';
import 'package:book_and_play/features/auth/domain/usecase/signin_usecase.dart';
import 'package:book_and_play/features/auth/presentation/manager/signin_cubit/signin_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SigninCubit extends Cubit<SigninState> {
  SigninCubit() : super(SigninInitialState());

  void signin({
    required SigninReqParams params,
    required SigninUsecase usecase,
  }) async {
    emit(SigninLoadingState());

    try {
      final Either<Failure, SigninResponse> result = await usecase.call(params);

      result.fold(
        (error) {
          log('Signup error: ${error.message}'); // Log the error message
          emit(SigninFailureState(errorMessage: error.message));
        },
        (data) async {
          await saveUserToken(data.token);
          await saveUserdata(
            data.user!.email,
            data.user!.name,
            data.user!.id,
            data.user!.role,
          );
          log('Signup successful: ${data.message}'); // Log success message
          emit(
            SigninSuccessState(
              message: data.message,
              token: data.token,
              user: data.user!,
              role: data.user!.role,
            ),
          ); // Ensure you pass the user's name if available
        },
      );
    } catch (e) {
      log('Exception occurred: $e'); // Log the exception
      emit(SigninFailureState(errorMessage: e.toString()));
    }
  }
}

Future<void> saveUserToken(String token) async {
  await SharedPrefHelper.setData(SharedPrefKeys.userToken, token);
  getIt<DioClient>().setTokenIntoHeaderAfterLogin(
    token,
  ); // Use the injected DioClient instance
}

Future<void> saveUserdata(
  String email,
  String name,
  String id,
  String role,
) async {
  await SharedPrefHelper.setData(SharedPrefKeys.userEmail, email);
  await SharedPrefHelper.setData(SharedPrefKeys.username, name);
  await SharedPrefHelper.setData(SharedPrefKeys.userid, id);
  await SharedPrefHelper.setData(SharedPrefKeys.userRole, role);
}
