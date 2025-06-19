import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/core/utils/api_service.dart';
import 'package:book_and_play/core/utils/constant.dart';
import 'package:book_and_play/features/owner/add_field/data/models/add_field_req.dart';
import 'package:book_and_play/features/owner/add_field/data/models/field_creation_res.dart';
import 'package:book_and_play/features/owner/add_field/data/models/places_res.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class AddFieldRemoteDataSource {
  Future<Either<Failure, FieldCreationResponse>> createField(
    AddFieldRequest addFieldReq,
  );
  Future<Either<Failure, PlacesResponse>> getPlaces(String query);
}

class AddFieldRemoteDataSourceImpl extends AddFieldRemoteDataSource {
  @override
  Future<Either<Failure, FieldCreationResponse>> createField(
    AddFieldRequest addFieldReq,
  ) async {
    try {
      final formData = await addFieldReq.toFormData();

      final request = await getIt<DioClient>().post(
        '${ApiUrls.field}/create',
        data: formData,
      );
      final response = FieldCreationResponse.fromJson(request.data);
      return Right(response);
    } on DioException catch (e) {
      return Left(Failure('connection error : ${e.message.toString()}'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PlacesResponse>> getPlaces(String query) async {
    try {
      final request = await getIt<DioClient>().get(
        ApiUrls.searchPlaces,
        queryParameters: {'query': query},
      );
      final response = PlacesResponse.fromJson(request.data);
      return Right(response);
    } on DioException catch (e) {
      return Left(Failure('connection error : ${e.toString()}'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
