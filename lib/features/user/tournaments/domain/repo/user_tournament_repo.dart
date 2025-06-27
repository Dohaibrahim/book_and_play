import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/features/user/tournaments/data/models/get_tournaments_res.dart';
import 'package:book_and_play/features/user/tournaments/data/models/tournament_details_res.dart';
import 'package:dartz/dartz.dart';

abstract class UserTournamentRepo {
  Future<Either<Failure, GetTournamentsRes>> fetchTournaments();
  Future<Either<Failure, TournamentDetailsRes>> getSpecificTournament(
    String id,
  );
}
