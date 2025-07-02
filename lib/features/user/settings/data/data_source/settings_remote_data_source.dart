import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/core/utils/api_service.dart';
import 'package:book_and_play/core/utils/constant.dart';
import 'package:book_and_play/features/user/settings/data/models/change_pass_req.dart';
import 'package:book_and_play/features/user/settings/data/models/change_pass_res.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class SettingsRemoteDataSource {
  Future<Either<ErrorResponse, ChangePassRes>> changePassword(
    ChangePassReq changePassReq,
  );
}

class SettingsRemoteDataSourceImpl extends SettingsRemoteDataSource {
  @override
  Future<Either<ErrorResponse, ChangePassRes>> changePassword(
    ChangePassReq changePassReq,
  ) async {
    try {
      final request = await getIt<DioClient>().patch(
        ApiUrls.changePassword,
        data: changePassReq.toJson(),
      );
      final response = ChangePassRes.fromJson(request.data);
      return Right(response);
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
