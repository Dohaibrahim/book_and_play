import 'dart:developer';

import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/features/owner/tournament/data/data_source/tournaments_data_source.dart';
import 'package:book_and_play/features/owner/tournament/data/models/add_tournament_req.dart';
import 'package:book_and_play/features/owner/tournament/data/models/add_tournament_res.dart';
import 'package:book_and_play/features/owner/tournament/domain/repo/add_tournament_repo.dart';
import 'package:dartz/dartz.dart';

class TournamentRepoImpl extends TournamentRepo {
  @override
  Future<Either<Failure, AddTournamentResponse>> addTournament(
    AddTournamentReq addTournamentReq,
  ) async {
    try {
      final result = await getIt<TournamentsDataSource>().addTournament(
        addTournamentReq,
      );
      return result.fold(
        (failure) {
          log('failllll , ${failure.message}');
          return Left(failure);
        },
        (data) {
          log('dataaaaa , ${data.message}');
          return Right(data);
        },
      );
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
