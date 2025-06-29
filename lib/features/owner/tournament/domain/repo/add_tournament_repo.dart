import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/features/owner/tournament/data/models/add_tournament_req.dart';
import 'package:book_and_play/features/owner/tournament/data/models/add_tournament_res.dart';
import 'package:book_and_play/features/owner/tournament/data/models/generate_next_round_req.dart';
import 'package:book_and_play/features/owner/tournament/data/models/get_spec_tournament_response.dart';
import 'package:book_and_play/features/owner/tournament/data/models/generate_next_res.dart';
import 'package:book_and_play/features/owner/tournament/data/models/teams_matches_res.dart';
import 'package:book_and_play/features/owner/tournament/data/models/tournaments_res.dart';
import 'package:dartz/dartz.dart';

abstract class TournamentRepo {
  Future<Either<Failure, AddTournamentResponse>> addTournament(
    AddTournamentReq addTournamentReq,
  );

  Future<Either<Failure, TournamentsResponse>> fetchAllTournaments();

  Future<Either<Failure, SpecificTournamentResponse>> getTournamentTeams(
    String id,
  );

  Future<Either<Failure, NextRoundRes>> generateNextRound(
    String id,
    NextRoundReq nextRoundReq,
  );

  Future<Either<Failure, TeamsMatchesRes>> getMatches(String tournamentId);
}
