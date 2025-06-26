import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/core/utils/api_service.dart';
import 'package:book_and_play/core/utils/constant.dart';
import 'package:book_and_play/features/user/tournaments/data/models/get_tournaments_res.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class UserTournamentsRemoteDataSource {
  Future<Either<Failure, GetTournamentsRes>> fetchTournaments();
}

class UserTournamentsRemoteDataSourceImpl
    extends UserTournamentsRemoteDataSource {
  @override
  Future<Either<Failure, GetTournamentsRes>> fetchTournaments() async {
    try {
      final request = await getIt<DioClient>().get('${ApiUrls.tournament}/all');
      final response = GetTournamentsRes.fromJson(request.data);
      return Right(response);
    } on DioException catch (e) {
      return Left(Failure(e.toString()));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
