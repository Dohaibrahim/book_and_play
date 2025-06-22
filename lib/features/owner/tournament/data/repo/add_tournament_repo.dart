import 'dart:developer';

import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/features/owner/tournament/data/data_source/tournaments_data_source.dart';
import 'package:book_and_play/features/owner/tournament/data/models/add_tournament_req.dart';
import 'package:book_and_play/features/owner/tournament/data/models/add_tournament_res.dart';
import 'package:book_and_play/features/owner/tournament/data/models/generate_next_round_req.dart';
import 'package:book_and_play/features/owner/tournament/data/models/get_spec_tournament_response.dart';
import 'package:book_and_play/features/owner/tournament/data/models/generate_next_res.dart';
import 'package:book_and_play/features/owner/tournament/data/models/tournaments_res.dart';
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

  @override
  Future<Either<Failure, TournamentResponse>> fetchAllTournaments() async {
    try {
      final result = await getIt<TournamentsDataSource>().fetchAllTournaments();
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

  @override
  Future<Either<Failure, SpecificTournamentResponse>> getTournamentTeams(
    String id,
  ) async {
    try {
      final result = await getIt<TournamentsDataSource>().getTournamentTeams(
        id,
      );
      return result.fold(
        (failure) {
          return Left(Failure(failure.toString()));
        },
        (data) {
          return Right(data);
        },
      );
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, NextRoundRes>> generateNextRound(
    String id,
    NextRoundReq nextRoundReq,
  ) async {
    try {
      final result = await getIt<TournamentsDataSource>().generateNextRound(
        id,
        nextRoundReq,
      );
      return result.fold(
        (failure) {
          return Left(Failure(failure.message.toString()));
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
