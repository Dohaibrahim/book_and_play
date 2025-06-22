import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/core/usecase/usecase.dart';
import 'package:book_and_play/features/owner/tournament/data/models/generate_next_res.dart';
import 'package:book_and_play/features/owner/tournament/data/models/generate_next_round_req.dart';
import 'package:book_and_play/features/owner/tournament/domain/repo/add_tournament_repo.dart';
import 'package:dartz/dartz.dart';

class GenerateNextRoundUsecase extends UseCase<NextRoundRes, NextRoundReq> {
  GenerateNextRoundUsecase({required this.id});
  final String id;
  @override
  Future<Either<Failure, NextRoundRes>> call([NextRoundReq? param]) async {
    return await getIt<TournamentRepo>().generateNextRound(id, param!);
  }
}
