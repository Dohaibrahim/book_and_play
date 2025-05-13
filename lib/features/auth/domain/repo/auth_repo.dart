import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/features/auth/data/model/signin_req_params.dart';
import 'package:book_and_play/features/auth/data/model/signin_response.dart';
import 'package:book_and_play/features/auth/data/model/signup_req_params.dart';
import 'package:book_and_play/features/auth/data/model/signup_response.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepo {
  Future<Either<Failure, SignupResponse>> signUp(SignupReqParams params);

  Future<Either<Failure, SigninResponse>> signIn(SigninReqParams params);
}
