import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/features/user/settings/data/models/change_pass_req.dart';
import 'package:book_and_play/features/user/settings/data/models/change_pass_res.dart';
import 'package:dartz/dartz.dart';

abstract class SettingsRepo {
  Future<Either<Failure, ChangePassRes>> changePassword(
    ChangePassReq changePassReq,
  );
}
