import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/core/usecase/usecase.dart';
import 'package:book_and_play/features/owner/matches/domain/repo/matches_repo.dart';
import 'package:dartz/dartz.dart';

class DeleteMatchUsecase extends UseCase<String, NoParam> {
  DeleteMatchUsecase({required this.matchId});
  final String matchId;
  @override
  Future<Either<Failure, String>> call([NoParam? param]) async {
    return await getIt<MatchesRepo>().deleteMatch(matchId);
  }
}
