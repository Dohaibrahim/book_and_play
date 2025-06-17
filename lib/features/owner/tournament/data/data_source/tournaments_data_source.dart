import 'dart:developer';

import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/core/utils/api_service.dart';
import 'package:book_and_play/core/utils/constant.dart';
import 'package:book_and_play/features/owner/tournament/data/models/add_tournament_req.dart';
import 'package:book_and_play/features/owner/tournament/data/models/add_tournament_res.dart';
import 'package:book_and_play/features/owner/tournament/data/models/tournaments_res.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class TournamentsDataSource {
  Future<Either<Failure, AddTournamentResponse>> addTournament(
    AddTournamentReq addTournamentReq,
  );

  Future<Either<Failure, TournamentResponse>> fetchAllTournaments();
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
  Future<Either<Failure, TournamentResponse>> fetchAllTournaments() async {
    try {
      var request = await getIt<DioClient>().get('${ApiUrls.tournament}/all');
      var response = TournamentResponse.fromJson(request.data);
      return Right(response);
    } on DioException catch (e) {
      return Left(Failure('connection error : ${e.toString()}'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
