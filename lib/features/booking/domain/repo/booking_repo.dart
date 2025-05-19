import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/features/booking/data/models/all_fields_res.dart';
import 'package:dartz/dartz.dart';

abstract class BookingRepo {
  Future<Either<Failure, List<Field>>> fetchFields();
  Future<Either<Failure, Field>> getFieldById(String id);
}
