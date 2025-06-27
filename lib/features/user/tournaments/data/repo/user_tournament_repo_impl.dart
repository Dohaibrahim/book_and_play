import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/features/user/tournaments/data/data_source/user_tournaments_remote_data_source.dart';
import 'package:book_and_play/features/user/tournaments/data/models/get_tournaments_res.dart';
import 'package:book_and_play/features/user/tournaments/data/models/tournament_details_res.dart';
import 'package:book_and_play/features/user/tournaments/domain/repo/user_tournament_repo.dart';
import 'package:dartz/dartz.dart';

class UserTournamentRepoImpl extends UserTournamentRepo {
  @override
  Future<Either<Failure, GetTournamentsRes>> fetchTournaments() async {
    try {
      final result = await getIt<UserTournamentsRemoteDataSource>()
          .fetchTournaments();
      return result.fold(
        (failure) {
          return Left(Failure(failure.message));
        },
        (data) {
          return Right(data);
        },
      );
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TournamentDetailsRes>> getSpecificTournament(
    String id,
  ) async {
    try {
      final result = await getIt<UserTournamentsRemoteDataSource>()
          .getSpecificTournament(id);
      return result.fold(
        (failure) {
          return Left(Failure(failure.message));
        },
        (data) {
          return Right(data);
        },
      );
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
