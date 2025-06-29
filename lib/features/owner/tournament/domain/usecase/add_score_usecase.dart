import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/core/usecase/usecase.dart';
import 'package:book_and_play/features/owner/tournament/data/models/add_score_req.dart';
import 'package:book_and_play/features/owner/tournament/data/models/add_score_res.dart';
import 'package:book_and_play/features/owner/tournament/domain/repo/add_tournament_repo.dart';
import 'package:dartz/dartz.dart';

class AddScoreUsecase extends UseCase<AddScoreRes, AddScoreReq> {
  final String id;
  AddScoreUsecase({required this.id});
  @override
  Future<Either<Failure, AddScoreRes>> call([AddScoreReq? param]) async {
    return await getIt<TournamentRepo>().addScore(id, param!);
  }
}
