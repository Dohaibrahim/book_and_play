import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/features/user/teams/data/models/specific_team_res.dart';
import 'package:book_and_play/features/user/teams/data/models/team_create_req.dart';
import 'package:book_and_play/features/user/teams/data/models/team_create_res.dart';
import 'package:dartz/dartz.dart';

abstract class PlayerTeamRepo {
  Future<Either<Failure, TeamCreateResponse>> creatTeam(
    CreateTeamRequest creatTeamReq,
  );

  Future<Either<Failure, SpecificTeamRes>> getSpecificTeam(String id);
}
