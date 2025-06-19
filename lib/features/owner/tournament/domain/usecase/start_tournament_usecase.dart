import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/core/usecase/usecase.dart';
import 'package:book_and_play/features/owner/tournament/data/models/start_tournaments_res.dart';
import 'package:book_and_play/features/owner/tournament/domain/repo/add_tournament_repo.dart';
import 'package:dartz/dartz.dart';

class StartTournamentUsecase
    extends UseCase<StartTournamentsResPonse, NoParam> {
  StartTournamentUsecase({required this.id});
  final String id;
  @override
  Future<Either<Failure, StartTournamentsResPonse>> call([
    NoParam? param,
  ]) async {
    return await getIt<TournamentRepo>().startTournament(id);
  }
}
