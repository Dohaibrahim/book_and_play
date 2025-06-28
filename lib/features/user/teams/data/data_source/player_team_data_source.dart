import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/core/utils/api_service.dart';
import 'package:book_and_play/core/utils/constant.dart';
import 'package:book_and_play/features/user/teams/data/models/add_player_to_team_req.dart';
import 'package:book_and_play/features/user/teams/data/models/add_player_to_team_res.dart';
import 'package:book_and_play/features/user/teams/data/models/specific_team_res.dart';
import 'package:book_and_play/features/user/teams/data/models/team_create_req.dart';
import 'package:book_and_play/features/user/teams/data/models/team_create_res.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class PlayerTeamDataSource {
  Future<Either<Failure, TeamCreateResponse>> creatTeam(
    CreateTeamRequest creatTeamReq,
  );

  Future<Either<Failure, SpecificTeamRes>> getSpecificTeam(String id);

  Future<Either<Failure, AddPlayerToTeamRes>> addPlayer(
    AddPlayerToTeamReq addPlayerReq,
  );
}

class PlayerTeamDataSourceImpl extends PlayerTeamDataSource {
  @override
  Future<Either<Failure, TeamCreateResponse>> creatTeam(
    CreateTeamRequest creatTeamReq,
  ) async {
    try {
      final formData = await creatTeamReq.toFormData();
      final request = await getIt<DioClient>().post(
        '${ApiUrls.team}/create',
        data: formData,
      );
      var response = TeamCreateResponse.fromJson(request.data);
      return Right(response);
    } on DioException catch (e) {
      return Left(Failure("connection error : ${e.message}"));
    } catch (e) {
      return Left(Failure("error at data source : ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, SpecificTeamRes>> getSpecificTeam(String id) async {
    try {
      final request = await getIt<DioClient>().get('${ApiUrls.team}/$id');
      var response = SpecificTeamRes.fromJson(request.data);
      return Right(response);
    } on DioException catch (e) {
      return Left(Failure("connection error : ${e.message}"));
    } catch (e) {
      return Left(Failure("error at data source : ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, AddPlayerToTeamRes>> addPlayer(
    AddPlayerToTeamReq addPlayerReq,
  ) async {
    try {
      final request = await getIt<DioClient>().post(
        '${ApiUrls.team}/add-member',
        data: addPlayerReq.toJson(),
      );
      var response = AddPlayerToTeamRes.fromJson(request.data);
      return Right(response);
    } on DioException catch (e) {
      return Left(Failure("connection error : ${e.message}"));
    } catch (e) {
      return Left(Failure("error at data source : ${e.toString()}"));
    }
  }
}
