import 'dart:developer';

import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/features/user/booking/data/data_source/booking_remote_data_source.dart';
import 'package:book_and_play/features/user/booking/data/models/all_fields_res.dart';
import 'package:book_and_play/features/user/booking/data/models/available_matches_model.dart';
import 'package:book_and_play/features/user/booking/data/models/join_match_model.dart';
import 'package:book_and_play/features/user/booking/domain/repo/booking_repo.dart';
import 'package:dartz/dartz.dart';

class BookingRepoImpl extends BookingRepo {
  @override
  Future<Either<Failure, List<Field>>> fetchFields() async {
    try {
      final result = await getIt<BookingRemoteDataSource>().fetchFields();

      return result.fold(
        (failure) {
          log(failure.toString());
          return Left(failure);
        },
        (allFieldsRes) {
          return Right(allFieldsRes.fields);
        },
      );
    } catch (e) {
      log(e.toString());
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Field>> getFieldById(String id) async {
    try {
      final result = await getIt<BookingRemoteDataSource>().getFieldById(id);
      return result.fold(
        (failure) {
          log(failure.toString());
          return Left(failure);
        },
        (field) {
          return Right(field.field);
        },
      );
    } catch (e) {
      log(e.toString());
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AvailableMatchesModel>> getAvailableMatches(
    String fieldId,
    String date,
  ) async {
    try {
      final result = await getIt<BookingRemoteDataSource>().getAvailableMatches(
        fieldId,
        date,
      );
      return result.fold(
        (failure) {
          log(failure.toString());
          return Left(failure);
        },
        (matches) {
          return Right(matches);
        },
      );
    } catch (e) {
      log(e.toString());
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, JoinMatchModel>> joinMatch(matchId) async {
    try {
      final result = await getIt<BookingRemoteDataSource>().joinMatch(matchId);
      return result.fold(
        (failure) {
          log(failure.toString());
          return Left(failure);
        },
        (joinMatch) {
          return Right(joinMatch);
        },
      );
    } catch (e) {
      log(e.toString());
      return Left(Failure(e.toString()));
    }
  }
}
