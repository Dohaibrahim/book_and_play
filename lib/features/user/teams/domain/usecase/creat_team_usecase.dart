import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/core/usecase/usecase.dart';
import 'package:book_and_play/features/user/teams/data/models/team_create_req.dart';
import 'package:book_and_play/features/user/teams/data/models/team_create_res.dart';
import 'package:book_and_play/features/user/teams/domain/repo/plater_team_repo.dart';
import 'package:dartz/dartz.dart';

class CreatTeamUsecase extends UseCase<TeamCreateResponse, CreateTeamRequest> {
  @override
  Future<Either<Failure, TeamCreateResponse>> call([
    CreateTeamRequest? param,
  ]) async {
    return await getIt<PlayerTeamRepo>().creatTeam(param!);
  }
}
