import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/core/usecase/usecase.dart';
import 'package:book_and_play/features/user/booking/data/models/join_match_model.dart';
import 'package:book_and_play/features/user/booking/domain/repo/booking_repo.dart';
import 'package:dartz/dartz.dart';

class JoinMatchUsecase extends UseCase<JoinMatchModel, NoParam> {
  final String id;
  final BookingRepo bookingRepo;
  JoinMatchUsecase({required this.bookingRepo, required this.id});
  @override
  Future<Either<Failure, JoinMatchModel>> call([NoParam? param]) async {
    return await bookingRepo.joinMatch(id);
  }
}
