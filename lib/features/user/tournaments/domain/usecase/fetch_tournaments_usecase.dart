import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/core/usecase/usecase.dart';
import 'package:book_and_play/features/user/tournaments/data/models/get_tournaments_res.dart';
import 'package:book_and_play/features/user/tournaments/domain/repo/user_tournament_repo.dart';
import 'package:dartz/dartz.dart';

class UserFetchTournamentsUsecase extends UseCase<GetTournamentsRes, NoParam> {
  @override
  Future<Either<Failure, GetTournamentsRes>> call([NoParam? param]) async {
    return await getIt<UserTournamentRepo>().fetchTournaments();
  }
}
