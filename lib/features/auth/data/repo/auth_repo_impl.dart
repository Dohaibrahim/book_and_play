import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/features/auth/data/data_source/data_source.dart';
import 'package:book_and_play/features/auth/data/model/signin_req_params.dart';
import 'package:book_and_play/features/auth/data/model/signin_response.dart';
import 'package:book_and_play/features/auth/data/model/signup_req_params.dart';
import 'package:book_and_play/features/auth/data/model/signup_response.dart';
import 'package:book_and_play/features/auth/domain/repo/auth_repo.dart';
import 'package:dartz/dartz.dart';

class AuthRepoImpl extends AuthRepo {
  @override
  Future<Either<Failure, SignupResponse>> signUp(SignupReqParams signupReq) {
    return getIt<AuthRemoteDataSource>().signUp(signupReq);
  }

  @override
  Future<Either<Failure, SigninResponse>> signIn(SigninReqParams signinReq) {
    return getIt<AuthRemoteDataSource>().signIn(signinReq);
  }
}
