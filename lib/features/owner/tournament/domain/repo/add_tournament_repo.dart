import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/features/owner/tournament/data/models/add_tournament_req.dart';
import 'package:book_and_play/features/owner/tournament/data/models/add_tournament_res.dart';
import 'package:dartz/dartz.dart';

abstract class TournamentRepo {
  Future<Either<Failure, AddTournamentResponse>> addTournament(
    AddTournamentReq addTournamentReq,
  );
}
