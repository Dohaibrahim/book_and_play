import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/features/owner/tournament/data/models/add_tournament_req.dart';
import 'package:book_and_play/features/owner/tournament/data/models/add_tournament_res.dart';
import 'package:book_and_play/features/owner/tournament/data/models/get_spec_tournament_response.dart';
import 'package:book_and_play/features/owner/tournament/data/models/start_tournaments_res.dart';
import 'package:book_and_play/features/owner/tournament/data/models/tournaments_res.dart';
import 'package:dartz/dartz.dart';

abstract class TournamentRepo {
  Future<Either<Failure, AddTournamentResponse>> addTournament(
    AddTournamentReq addTournamentReq,
  );

  Future<Either<Failure, TournamentResponse>> fetchAllTournaments();

  Future<Either<Failure, SpecificTournamentResponse>> getTournamentTeams(
    String id,
  );

  Future<Either<Failure, StartTournamentsResPonse>> startTournament(String id);
}
