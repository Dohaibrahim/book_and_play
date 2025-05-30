import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/core/utils/api_service.dart';
import 'package:book_and_play/core/utils/constant.dart';
import 'package:book_and_play/features/user/user_booking/data/models/user_matches_res.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class UserBookingRemoteDataSource {
  Future<Either<Failure, UserMatchesResponse>> getUserMatches(String userId);
}

class UserBookingRemoteDataSourceImpl extends UserBookingRemoteDataSource {
  @override
  Future<Either<Failure, UserMatchesResponse>> getUserMatches(
    String userId,
  ) async {
    try {
      var result = await getIt<DioClient>().get('${ApiUrls.match}/$userId');
      UserMatchesResponse userMatchesResponse = UserMatchesResponse.fromJson(
        result.data,
      );
      return Right(userMatchesResponse);
    } on DioException catch (e) {
      return Left(
        Failure(
          'Connection Error! Please check your internet connection and try again',
        ),
      );
    } catch (e) {
      return Left(Failure('error : ${e.toString()}'));
    }
  }
}
