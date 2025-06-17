import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/core/usecase/usecase.dart';
import 'package:book_and_play/features/owner/tournament/data/models/add_tournament_req.dart';
import 'package:book_and_play/features/owner/tournament/data/models/add_tournament_res.dart';
import 'package:book_and_play/features/owner/tournament/domain/repo/add_tournament_repo.dart';
import 'package:dartz/dartz.dart';

class AddTournamentUsecase
    extends UseCase<AddTournamentResponse, AddTournamentReq> {
  @override
  Future<Either<Failure, AddTournamentResponse>> call([
    AddTournamentReq? param,
  ]) async {
    return await getIt<TournamentRepo>().addTournament(param!);
  }
}
