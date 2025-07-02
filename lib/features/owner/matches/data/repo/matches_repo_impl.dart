import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/features/owner/matches/data/data_source/matches_remote_data_source.dart';
import 'package:book_and_play/features/owner/matches/data/models/create_match_req.dart';
import 'package:book_and_play/features/owner/matches/data/models/create_match_res.dart';
import 'package:book_and_play/features/owner/matches/domain/repo/matches_repo.dart';
import 'package:dartz/dartz.dart';

class MatchesRepoImpl extends MatchesRepo {
  @override
  Future<Either<Failure, CreateMatchRes>> createMatch(
    CreateMatchReq createMatchReq,
  ) async {
    final result = await getIt<MatchesRemoteDataSource>().createMatch(
      createMatchReq,
    );
    return result.fold(
      (failure) {
        return Left(Failure(failure.message));
      },
      (data) {
        return Right(data);
      },
    );
  }
}
