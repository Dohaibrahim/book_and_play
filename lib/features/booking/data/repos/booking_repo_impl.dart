import 'dart:developer';

import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/features/booking/data/data_source/booking_remote_data_source.dart';
import 'package:book_and_play/features/booking/data/models/all_fields_res.dart';
import 'package:book_and_play/features/booking/domain/repo/booking_repo.dart';
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
}
