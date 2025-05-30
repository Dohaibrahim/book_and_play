import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/features/user/user_booking/data/data_source/user_booking_remote_data_source.dart';
import 'package:book_and_play/features/user/user_booking/data/models/user_matches_res.dart';
import 'package:book_and_play/features/user/user_booking/domain/repo/user_booking_repo.dart';
import 'package:dartz/dartz.dart';

class UserBookingRepoImpl extends UserBookingRepo {
  @override
  Future<Either<Failure, UserMatchesResponse>> getUserMatches(
    String userId,
  ) async {
    try {
      final result = await getIt<UserBookingRemoteDataSource>().getUserMatches(
        userId,
      );
      return result.fold(
        (failure) {
          return Left(Failure('error : ${failure.toString()}'));
        },
        (matches) {
          return Right(matches);
        },
      );
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
