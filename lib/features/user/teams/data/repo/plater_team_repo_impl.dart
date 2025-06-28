import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/features/user/teams/data/data_source/player_team_data_source.dart';
import 'package:book_and_play/features/user/teams/data/models/team_create_req.dart';
import 'package:book_and_play/features/user/teams/data/models/team_create_res.dart';
import 'package:book_and_play/features/user/teams/domain/repo/plater_team_repo.dart';
import 'package:dartz/dartz.dart';

class PlayerTeamRepoImpl extends PlayerTeamRepo {
  @override
  Future<Either<Failure, TeamCreateResponse>> creatTeam(
    CreateTeamRequest creatTeamReq,
  ) async {
    try {
      final result = await getIt<PlayerTeamDataSource>().creatTeam(
        creatTeamReq,
      );
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
