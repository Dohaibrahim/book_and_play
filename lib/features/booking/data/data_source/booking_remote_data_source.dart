import 'dart:developer';

import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/core/utils/api_service.dart';
import 'package:book_and_play/core/utils/constant.dart';
import 'package:book_and_play/features/booking/data/models/all_fields_res.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class BookingRemoteDataSource {
  Future<Either<Failure, AllFieldsRes>> fetchFields();
}

class BookingRemoteDataSourceImpl extends BookingRemoteDataSource {
  @override
  Future<Either<Failure, AllFieldsRes>> fetchFields() async {
    try {
      var response = await getIt<DioClient>().get(ApiUrls.gatAllFields);
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
}

AllFieldsRes getFieldsRes(Map<String, dynamic> data) {
  return AllFieldsRes.fromJson(data);
}
