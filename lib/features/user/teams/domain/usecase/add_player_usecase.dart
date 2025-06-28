import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/core/usecase/usecase.dart';
import 'package:book_and_play/features/user/teams/data/models/add_player_to_team_req.dart';
import 'package:book_and_play/features/user/teams/data/models/add_player_to_team_res.dart';
import 'package:book_and_play/features/user/teams/domain/repo/plater_team_repo.dart';
import 'package:dartz/dartz.dart';

class AddPlayerUsecase extends UseCase<AddPlayerToTeamRes, AddPlayerToTeamReq> {
  @override
  Future<Either<Failure, AddPlayerToTeamRes>> call([
    AddPlayerToTeamReq? param,
  ]) async {
    return await getIt<PlayerTeamRepo>().addPlayer(param!);
  }
}
