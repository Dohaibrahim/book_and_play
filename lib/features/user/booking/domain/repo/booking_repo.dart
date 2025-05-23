import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/features/user/booking/data/models/all_fields_res.dart';
import 'package:book_and_play/features/user/booking/data/models/available_matches_model.dart';
import 'package:book_and_play/features/user/booking/data/models/join_match_model.dart';
import 'package:dartz/dartz.dart';

abstract class BookingRepo {
  Future<Either<Failure, List<Field>>> fetchFields();
  Future<Either<Failure, Field>> getFieldById(String id);
  Future<Either<Failure, AvailableMatchesModel>> getAvailableMatches(
    String fieldId,
    String date,
  );
  Future<Either<Failure, JoinMatchModel>> joinMatch(matchId);
}
