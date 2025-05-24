import 'dart:developer';

import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/core/utils/api_service.dart';
import 'package:book_and_play/core/utils/constant.dart';
import 'package:book_and_play/core/utils/shared_pref.dart';
import 'package:book_and_play/features/user/booking/data/models/all_fields_res.dart';
import 'package:book_and_play/features/user/booking/data/models/available_matches_model.dart';
import 'package:book_and_play/features/user/booking/data/models/field_by_id_model.dart';
import 'package:book_and_play/features/user/booking/data/models/join_match_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class BookingRemoteDataSource {
  Future<Either<Failure, AllFieldsRes>> fetchFields();
  Future<Either<Failure, FieldByIdModel>> getFieldById(String id);
  Future<Either<Failure, AvailableMatchesModel>> getAvailableMatches(
    String fieldId,
    String date,
  );
  Future<Either<Failure, JoinMatchModel>> joinMatch(matchId);
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

  @override
  Future<Either<Failure, AvailableMatchesModel>> getAvailableMatches(
    String fieldId,
    String date,
  ) async {
    try {
      var response = await getIt<DioClient>().get(
        ApiUrls.availableMatches,
        queryParameters: {'date': date, 'fieldId': fieldId},
      );
      log(response.toString());
      AvailableMatchesModel matches = AvailableMatchesModel.fromJson(
        response.data,
      );

      return Right(matches);
    } on DioException catch (e) {
      log('connection error ');
      return Left(Failure(e.toString()));
    } catch (e) {
      log(
        'error in getAvailableMatches field remote data source ${e.toString()}',
      );
      return Left(
        Failure('error in field remote data source : ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, JoinMatchModel>> joinMatch(matchId) async {
    try {
      var response = await getIt<DioClient>().post(
        '${ApiUrls.match}/$matchId/join',
        options: Options(
          headers: {
            'Authorization':
                'Bearer ${await SharedPrefHelper.getString(SharedPrefKeys.userToken)}',
            'Content-Type': 'application/json',
          },
        ),
      );
      JoinMatchModel joinMatchModel = JoinMatchModel.fromJson(response.data);
      return Right(joinMatchModel);
    } on DioException catch (e) {
      log('DioException: ${e.toString()}');

      if (e.type == DioExceptionType.connectionTimeout) {
        return Left(
          Failure('Connection timed out. Please check your internet.'),
        );
      } else if (e.type == DioExceptionType.receiveTimeout) {
        return Left(Failure('Server is not responding. Try again later.'));
      } else if (e.type == DioExceptionType.badResponse) {
        final statusCode = e.response?.statusCode;
        final message =
            e.response?.data['message'] ?? 'Unexpected error occurred.';

        if (statusCode == 409) {
          return Left(Failure('You have already joined this match.'));
        } else if (statusCode == 500) {
          return Left(Failure('Server error. Please try again later.'));
        } else if (statusCode == 400) {
          return Left(Failure(message));
        }

        return Left(Failure(message));
      }

      return Left(Failure('Something went wrong. Please try again.'));
    } catch (e) {
      log('joinMatch error: ${e.toString()}');
      return Left(Failure('Unexpected error occurred. Please try again.'));
    }
  }
}

AllFieldsRes getFieldsRes(Map<String, dynamic> data) {
  return AllFieldsRes.fromJson(data);
}
