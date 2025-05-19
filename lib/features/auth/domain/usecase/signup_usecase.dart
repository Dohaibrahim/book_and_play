import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/core/usecase/usecase.dart';
import 'package:book_and_play/features/auth/data/model/signup_req_params.dart';
import 'package:book_and_play/features/auth/data/model/signup_response.dart';
import 'package:book_and_play/features/auth/domain/repo/auth_repo.dart';
import 'package:dartz/dartz.dart';

class SignupUsecase implements UseCase<SignupResponse, SignupReqParams> {
  final String role;
  SignupUsecase(this.role);
  @override
  Future<Either<Failure, SignupResponse>> call([SignupReqParams? param]) async {
    return await getIt<AuthRepo>().signUp(param!, role);
  }
}
