import 'dart:developer';

import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/core/utils/api_service.dart';
import 'package:book_and_play/core/utils/constant.dart';
import 'package:book_and_play/features/booking/data/models/all_fields_res.dart';
import 'package:book_and_play/features/booking/data/models/field_by_id_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class BookingRemoteDataSource {
  Future<Either<Failure, AllFieldsRes>> fetchFields();
  Future<Either<Failure, FieldByIdModel>> getFieldById(String id);
}

class BookingRemoteDataSourceImpl extends BookingRemoteDataSource {
  @override
  Future<Either<Failure, AllFieldsRes>> fetchFields() async {
    try {
      var response = await getIt<DioClient>().get('${ApiUrls.field}/allfields');
      AllFieldsRes fieldsRes = getFieldsRes(response.data);
      return Right(fieldsRes);
    } on DioException catch (e) {
      log('connection error ');
      return Left(Failure(e.toString()));
    } catch (e) {
      log('error in categories remote data source ${e.toString()}');
      return Left(
        Failure('error in categories remote data source : ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, FieldByIdModel>> getFieldById(String id) async {
    try {
      var response = await getIt<DioClient>().get('${ApiUrls.field}/$id');
      FieldByIdModel field = FieldByIdModel.fromJson(response.data);
      return Right(field);
    } on DioException catch (e) {
      log('connection error ');
      return Left(Failure(e.toString()));
    } catch (e) {
      log('error in getFieldById field remote data source ${e.toString()}');
      return Left(
        Failure('error in field remote data source : ${e.toString()}'),
      );
    }
  }
}

AllFieldsRes getFieldsRes(Map<String, dynamic> data) {
  return AllFieldsRes.fromJson(data);
}
