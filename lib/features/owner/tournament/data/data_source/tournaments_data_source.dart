import 'dart:developer';

import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/core/utils/api_service.dart';
import 'package:book_and_play/core/utils/constant.dart';
import 'package:book_and_play/features/owner/tournament/data/models/add_tournament_req.dart';
import 'package:book_and_play/features/owner/tournament/data/models/add_tournament_res.dart';
import 'package:book_and_play/features/owner/tournament/data/models/generate_next_round_req.dart';
import 'package:book_and_play/features/owner/tournament/data/models/get_spec_tournament_response.dart';
import 'package:book_and_play/features/owner/tournament/data/models/generate_next_res.dart';
import 'package:book_and_play/features/owner/tournament/data/models/teams_matches_res.dart';
import 'package:book_and_play/features/owner/tournament/data/models/tournaments_res.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class TournamentsDataSource {
  Future<Either<Failure, AddTournamentResponse>> addTournament(
    AddTournamentReq addTournamentReq,
  );

  Future<Either<Failure, TournamentsResponse>> fetchAllTournaments();

  Future<Either<Failure, SpecificTournamentResponse>> getTournamentTeams(
    String id,
  );

  Future<Either<Failure, NextRoundRes>> generateNextRound(
    String id,
    NextRoundReq nextRoundReq,
  );

  Future<Either<Failure, TeamsMatchesRes>> getMatches(String tournamentId);
}

class TournamentsDataSourceImpl extends TournamentsDataSource {
  @override
  Future<Either<Failure, AddTournamentResponse>> addTournament(
    AddTournamentReq addTournamentReq,
  ) async {
    try {
      var request = await getIt<DioClient>().post(
        '${ApiUrls.tournament}/create',
        data: addTournamentReq.toJson(),
      );
      var response = AddTournamentResponse.fromJson(request.data);
      log('dataaaaa ${response.message}');
      return Right(response);
    } on DioException catch (e) {
      return Left(Failure(e.toString()));
    } catch (e) {
      return Left(Failure('error : ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, TournamentsResponse>> fetchAllTournaments() async {
    try {
      var request = await getIt<DioClient>().get(
        '${ApiUrls.tournament}/my-field-tournaments',
      );
      var response = TournamentsResponse.fromJson(request.data);
      return Right(response);
    } on DioException catch (e) {
      return Left(Failure('connection error : ${e.toString()}'));
    } catch (e, s) {
      log('❌ Error parsing response: $e');
      log('🔍 Stack: $s');
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SpecificTournamentResponse>> getTournamentTeams(
    String id,
  ) async {
    try {
      var request = await getIt<DioClient>().get('${ApiUrls.tournament}/$id');

      var response = SpecificTournamentResponse.fromJson(request.data);
      log('ressss=> ${response.message.toString()}');
      return Right(response);
    } on DioException catch (e) {
      return Left(Failure('connection error : ${e.toString()}'));
    } catch (e) {
      log(e.toString());
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, NextRoundRes>> generateNextRound(
    String id,
    NextRoundReq nextRoundReq,
  ) async {
    try {
      var requset = await getIt<DioClient>().post(
        '${ApiUrls.knockoutTournaments}/$id/generate',
        data: nextRoundReq.toJson(),
      );
      var response = NextRoundRes.fromJson(requset.data);

      return Right(response);
    } on DioException catch (e) {
      return Left(Failure('connection error : ${e.toString()}'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TeamsMatchesRes>> getMatches(
    String tournamentId,
  ) async {
    try {
      var request = await getIt<DioClient>().get(
        '${ApiUrls.knockoutTournaments}/$tournamentId/matches',
      );
      var response = TeamsMatchesRes.fromJson(request.data);
      return Right(response);
    } on DioException catch (e) {
      return Left(Failure('connection error : ${e.toString()}'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
