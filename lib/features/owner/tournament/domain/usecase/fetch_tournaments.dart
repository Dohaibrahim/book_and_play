import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/core/usecase/usecase.dart';
import 'package:book_and_play/features/owner/tournament/data/models/tournaments_res.dart';
import 'package:book_and_play/features/owner/tournament/domain/repo/add_tournament_repo.dart';
import 'package:dartz/dartz.dart';

class FetchTournamentsUsecase extends UseCase<TournamentResponse, NoParam> {
  @override
  Future<Either<Failure, TournamentResponse>> call([NoParam? param]) async {
    return await getIt<TournamentRepo>().fetchAllTournaments();
  }
}
