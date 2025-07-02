import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/core/usecase/usecase.dart';
import 'package:book_and_play/features/user/settings/data/models/change_pass_req.dart';
import 'package:book_and_play/features/user/settings/data/models/change_pass_res.dart';
import 'package:book_and_play/features/user/settings/domain/repo/settings_repo.dart';
import 'package:dartz/dartz.dart';

class ChangePasswordUsecase extends UseCase<ChangePassRes, ChangePassReq> {
  @override
  Future<Either<Failure, ChangePassRes>> call([ChangePassReq? param]) async {
    return await getIt<SettingsRepo>().changePassword(param!);
  }
}
