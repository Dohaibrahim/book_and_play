import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/core/usecase/usecase.dart';
import 'package:book_and_play/features/owner/tournament/data/models/teams_matches_res.dart';
import 'package:book_and_play/features/owner/tournament/domain/repo/add_tournament_repo.dart';
import 'package:dartz/dartz.dart';

class GetMatchesUsecaes extends UseCase<TeamsMatchesRes, NoParam> {
  final String id;
  GetMatchesUsecaes({required this.id});

  @override
  Future<Either<Failure, TeamsMatchesRes>> call([NoParam? param]) async {
    return await getIt<TournamentRepo>().getMatches(id);
  }
}
