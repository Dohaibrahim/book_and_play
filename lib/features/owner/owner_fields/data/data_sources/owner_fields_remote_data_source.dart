import 'dart:developer';

import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/core/utils/api_service.dart';
import 'package:book_and_play/core/utils/constant.dart';
import 'package:book_and_play/core/utils/shared_pref.dart';
import 'package:book_and_play/features/owner/owner_fields/data/models/delete_field_res.dart';
import 'package:book_and_play/features/owner/owner_fields/data/models/owner_fields.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class OwnerFieldsRemoteDataSource {
  Future<Either<Failure, FieldResponse>> getOwnerFields();
  Future<Either<ErrorResponse, DeletedFieldResponse>> deleteField(
    String fieldId,
  );
}

class OwnerFieldsRemoteDataSourceImpl extends OwnerFieldsRemoteDataSource {
  @override
  Future<Either<Failure, FieldResponse>> getOwnerFields() async {
    try {
      var response = await getIt<DioClient>().get(
        '${ApiUrls.field}/my-fields',
        options: Options(headers: {'token': await getUserToken()}),
      );
      FieldResponse ownerFieldRes = FieldResponse.fromJson(response.data);
      return Right(ownerFieldRes);
    } on DioException catch (e) {
      log('at owner field remote data source DioException , ${e.toString()}');
      return Left(
        Failure(
          'Connection error, please check your internet connection and try again',
        ),
      );
    } catch (e) {
      log('at owner field remote data source catch (e) , ${e.toString()}');
      return Left(Failure(e.toString()));
    }
  }

  Future<String> getUserToken() async {
    return await SharedPrefHelper.getString(SharedPrefKeys.userToken);
  }

  @override
  Future<Either<ErrorResponse, DeletedFieldResponse>> deleteField(
    String fieldId,
  ) async {
    try {
      var response = await getIt<DioClient>().delete(
        '${ApiUrls.field}/delete/$fieldId',
      );
      DeletedFieldResponse deletedRes = DeletedFieldResponse.fromJson(response);
      return Right(deletedRes);
    } on DioException catch (e) {
      if (e.response != null && e.response?.data != null) {
        final data = e.response?.data;
        try {
          return Left(ErrorResponse.fromJson(data));
        } catch (_) {
          return Left(
            ErrorResponse(
              error: 'Unknown',
              message: 'Failed to parse error response',
              code: e.response?.statusCode ?? 0,
            ),
          );
        }
      } else {
        return Left(
          ErrorResponse(
            error: 'No Response',
            message: 'No response received from server',
            code: e.response?.statusCode ?? 0,
          ),
        );
      }
    } catch (e) {
      return Left(
        ErrorResponse(error: 'Exception', message: e.toString(), code: 0),
      );
    }
  }
}
