import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/features/owner/owner_fields/data/models/delete_field_res.dart';
import 'package:book_and_play/features/owner/owner_fields/data/models/owner_fields.dart';
import 'package:dartz/dartz.dart';

abstract class OwnerFieldRepo {
  Future<Either<Failure, List<OwnerField>>> getOwnerFields();
  Future<Either<Failure, DeletedFieldResponse>> deleteField(String fieldId);
}
