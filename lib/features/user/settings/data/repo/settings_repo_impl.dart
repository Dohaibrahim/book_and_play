import 'dart:developer';

import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/features/user/settings/data/data_source/settings_remote_data_source.dart';
import 'package:book_and_play/features/user/settings/data/models/change_pass_req.dart';
import 'package:book_and_play/features/user/settings/data/models/change_pass_res.dart';
import 'package:book_and_play/features/user/settings/domain/repo/settings_repo.dart';
import 'package:dartz/dartz.dart';

class SettingsRepoImpl extends SettingsRepo {
  @override
  Future<Either<Failure, ChangePassRes>> changePassword(
    ChangePassReq changePassReq,
  ) async {
    try {
      final result = await getIt<SettingsRemoteDataSource>().changePassword(
        changePassReq,
      );
      return result.fold(
        (failure) {
          log(failure.message);
          return Left(Failure(failure.message));
        },
        (data) {
          return Right(data);
        },
      );
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
