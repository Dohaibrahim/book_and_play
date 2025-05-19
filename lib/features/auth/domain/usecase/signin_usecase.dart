import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/core/usecase/usecase.dart';
import 'package:book_and_play/features/auth/data/model/signin_req_params.dart';
import 'package:book_and_play/features/auth/data/model/signin_response.dart';
import 'package:book_and_play/features/auth/domain/repo/auth_repo.dart';
import 'package:dartz/dartz.dart';

class SigninUsecase implements UseCase<SigninResponse, SigninReqParams> {
  SigninUsecase();
  @override
  Future<Either<Failure, SigninResponse>> call([
    SigninReqParams? signinReq,
  ]) async {
    return await getIt<AuthRepo>().signIn(signinReq!);
  }
}
