import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/core/usecase/usecase.dart';
import 'package:book_and_play/features/user/tournaments/data/models/tournament_details_res.dart';
import 'package:book_and_play/features/user/tournaments/domain/repo/user_tournament_repo.dart';
import 'package:dartz/dartz.dart';

class GetSpecificTournamentUsecase
    extends UseCase<TournamentDetailsRes, NoParam> {
  GetSpecificTournamentUsecase({required this.id});
  final String id;
  @override
  Future<Either<Failure, TournamentDetailsRes>> call([NoParam? param]) async {
    return await getIt<UserTournamentRepo>().getSpecificTournament(id);
  }
}
