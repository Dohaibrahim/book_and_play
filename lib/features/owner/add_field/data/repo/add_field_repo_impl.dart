import 'dart:developer';
import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/features/owner/add_field/data/data_source/add_field_remote_data_source.dart';
import 'package:book_and_play/features/owner/add_field/data/models/add_field_req.dart';
import 'package:book_and_play/features/owner/add_field/data/models/field_creation_res.dart';
import 'package:book_and_play/features/owner/add_field/data/models/places_res.dart';
import 'package:book_and_play/features/owner/add_field/domain/repo/add_field_repo.dart';
import 'package:dartz/dartz.dart';

class AddFieldRepoImpl extends AddFieldRepo {
  @override
  Future<Either<Failure, FieldCreationResponse>> createField(
    AddFieldRequest addFieldReq,
  ) async {
    try {
      final result = await getIt<AddFieldRemoteDataSource>().createField(
        addFieldReq,
      );
      return result.fold(
        (failure) {
          log('error : ${failure.message}');
          return Left(Failure(failure.message));
        },
        (data) {
          return Right(data);
        },
      );
    } catch (e) {
      log('error : ${e.toString()}');
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PlacesResponse>> getPlaces(String query) async {
    try {
      final result = await getIt<AddFieldRemoteDataSource>().getPlaces(query);
      return result.fold(
        (failure) {
          log('error : ${failure.message}');
          return Left(Failure(failure.message));
        },
        (data) {
          return Right(data);
        },
      );
    } catch (e) {
      log('error : ${e.toString()}');
      return Left(Failure(e.toString()));
    }
  }
}
