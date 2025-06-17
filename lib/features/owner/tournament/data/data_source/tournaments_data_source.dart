import 'dart:developer';

import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/core/utils/api_service.dart';
import 'package:book_and_play/core/utils/constant.dart';
import 'package:book_and_play/features/owner/tournament/data/models/add_tournament_req.dart';
import 'package:book_and_play/features/owner/tournament/data/models/add_tournament_res.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class TournamentsDataSource {
  Future<Either<Failure, AddTournamentResponse>> addTournament(
    AddTournamentReq addTournamentReq,
  );
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
}
