import 'dart:developer';
import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/features/owner/owner_fields/data/data_sources/owner_fields_remote_data_source.dart';
import 'package:book_and_play/features/owner/owner_fields/data/models/delete_field_res.dart';
import 'package:book_and_play/features/owner/owner_fields/data/models/owner_fields.dart';
import 'package:book_and_play/features/owner/owner_fields/domain/repo/owner_field_repo.dart';
import 'package:dartz/dartz.dart';

class OwnerFieldsRepoImpl extends OwnerFieldRepo {
  @override
  Future<Either<Failure, List<OwnerField>>> getOwnerFields() async {
    try {
      final result = await getIt<OwnerFieldsRemoteDataSource>()
          .getOwnerFields();
      return result.fold(
        (failure) {
          log(failure.toString());
          return Left(Failure(failure.toString()));
        },
        (fields) {
          return Right(fields.fields);
        },
      );
    } catch (e) {
      log(e.toString());
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DeletedFieldResponse>> deleteField(
    String fieldId,
  ) async {
    try {
      final result = await getIt<OwnerFieldsRemoteDataSource>().deleteField(
        fieldId,
      );
      return result.fold(
        (failure) {
          log(failure.toString());
          return Left(Failure(failure.message.toString()));
        },
        (res) {
          return Right(res);
        },
      );
    } catch (e) {
      log(e.toString());
      return Left(Failure(e.toString()));
    }
  }
}
