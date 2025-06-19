import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/features/owner/add_field/data/models/add_field_req.dart';
import 'package:book_and_play/features/owner/add_field/data/models/field_creation_res.dart';
import 'package:book_and_play/features/owner/add_field/data/models/places_res.dart';
import 'package:dartz/dartz.dart';

abstract class AddFieldRepo {
  Future<Either<Failure, FieldCreationResponse>> createField(
    AddFieldRequest addFieldReq,
  );
  Future<Either<Failure, PlacesResponse>> getPlaces(String query);
}
