import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/features/user/user_booking/data/models/user_matches_res.dart';
import 'package:dartz/dartz.dart';

abstract class UserBookingRepo {
  Future<Either<Failure, UserMatchesResponse>> getUserMatches(String userId);
}
