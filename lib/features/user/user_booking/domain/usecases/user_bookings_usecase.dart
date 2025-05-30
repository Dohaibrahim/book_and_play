import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/core/usecase/usecase.dart';
import 'package:book_and_play/core/utils/constant.dart';
import 'package:book_and_play/core/utils/shared_pref.dart';
import 'package:book_and_play/features/user/user_booking/data/models/user_matches_res.dart';
import 'package:book_and_play/features/user/user_booking/domain/repo/user_booking_repo.dart';
import 'package:dartz/dartz.dart';

class UserBookingsUsecase extends UseCase<UserMatchesResponse, NoParam> {
  final UserBookingRepo userBookingRepo;
  UserBookingsUsecase({required this.userBookingRepo});
  @override
  Future<Either<Failure, UserMatchesResponse>> call([NoParam? param]) async {
    return await userBookingRepo.getUserMatches(await getUserId());
  }

  Future<String> getUserId() async {
    return await SharedPrefHelper.getString(SharedPrefKeys.userid);
  }
}
