import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/core/usecase/usecase.dart';
import 'package:book_and_play/features/owner/tournament/data/models/get_spec_tournament_response.dart';
import 'package:book_and_play/features/owner/tournament/domain/repo/add_tournament_repo.dart';
import 'package:dartz/dartz.dart';

class GetTournamentTeamsUsecase
    extends UseCase<SpecificTournamentResponse, NoParam> {
  GetTournamentTeamsUsecase(this.id);
  final String id;
  @override
  Future<Either<Failure, SpecificTournamentResponse>> call([
    NoParam? param,
  ]) async {
    return await getIt<TournamentRepo>().getTournamentTeams(id);
  }
}
