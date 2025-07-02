import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/features/owner/matches/data/models/create_match_req.dart';
import 'package:book_and_play/features/owner/matches/data/models/create_match_res.dart';
import 'package:dartz/dartz.dart';

abstract class MatchesRepo {
  Future<Either<Failure, CreateMatchRes>> createMatch(
    CreateMatchReq createMatchReq,
  );
}
