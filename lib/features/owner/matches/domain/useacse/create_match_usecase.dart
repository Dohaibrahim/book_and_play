import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/core/usecase/usecase.dart';
import 'package:book_and_play/features/owner/matches/data/models/create_match_req.dart';
import 'package:book_and_play/features/owner/matches/data/models/create_match_res.dart';
import 'package:book_and_play/features/owner/matches/domain/repo/matches_repo.dart';
import 'package:dartz/dartz.dart';

class CreateMatchUsecase extends UseCase<CreateMatchRes, CreateMatchReq> {
  @override
  Future<Either<Failure, CreateMatchRes>> call([CreateMatchReq? param]) async {
    return await getIt<MatchesRepo>().createMatch(param!);
  }
}
