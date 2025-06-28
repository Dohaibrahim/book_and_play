import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/core/usecase/usecase.dart';
import 'package:book_and_play/features/user/teams/data/models/specific_team_res.dart';
import 'package:book_and_play/features/user/teams/domain/repo/plater_team_repo.dart';
import 'package:dartz/dartz.dart';

class GetSpecificTeamUsecase extends UseCase<SpecificTeamRes, NoParam> {
  final String id;
  GetSpecificTeamUsecase({required this.id});
  @override
  Future<Either<Failure, SpecificTeamRes>> call([NoParam? param]) async {
    return await getIt<PlayerTeamRepo>().getSpecificTeam(id);
  }
}
