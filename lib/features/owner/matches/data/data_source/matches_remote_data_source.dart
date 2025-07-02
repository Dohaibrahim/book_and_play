import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/core/utils/api_service.dart';
import 'package:book_and_play/core/utils/constant.dart';
import 'package:book_and_play/features/owner/matches/data/models/create_match_req.dart';
import 'package:book_and_play/features/owner/matches/data/models/create_match_res.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class MatchesRemoteDataSource {
  Future<Either<ErrorResponse, CreateMatchRes>> createMatch(
    CreateMatchReq createMatchReq,
  );
}

class MatchesRemoteDataSourceImpl extends MatchesRemoteDataSource {
  @override
  Future<Either<ErrorResponse, CreateMatchRes>> createMatch(
    CreateMatchReq createMatchReq,
  ) async {
    try {
      final request = await getIt<DioClient>().post(
        '${ApiUrls.match}/create',
        data: createMatchReq.toJson(),
      );
      final response = CreateMatchRes.fromJson(request.data);
      return Right(response);
    } on DioException catch (e) {
      if (e.response != null && e.response?.data != null) {
        final data = e.response?.data;
        try {
          return Left(ErrorResponse.fromJson(data));
        } catch (_) {
          return Left(
            ErrorResponse(
              error: 'Unknown',
              message: 'Failed to parse error response',
              code: e.response?.statusCode ?? 0,
            ),
          );
        }
      } else {
        return Left(
          ErrorResponse(
            error: 'No Response',
            message: 'No response received from server',
            code: e.response?.statusCode ?? 0,
          ),
        );
      }
    } catch (e) {
      return Left(
        ErrorResponse(error: 'Exception', message: e.toString(), code: 0),
      );
    }
  }
}
