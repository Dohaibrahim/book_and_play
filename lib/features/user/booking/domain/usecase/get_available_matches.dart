import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/core/usecase/usecase.dart';
import 'package:book_and_play/features/user/booking/data/models/available_matches_model.dart';
import 'package:book_and_play/features/user/booking/domain/repo/booking_repo.dart';
import 'package:dartz/dartz.dart';

class GetAvailableMatchesUseCase
    extends UseCase<AvailableMatchesModel, NoParam> {
  final BookingRepo bookingRepo;
  final String fieldId, date;
  GetAvailableMatchesUseCase({
    required this.bookingRepo,
    required this.date,
    required this.fieldId,
  });

  @override
  Future<Either<Failure, AvailableMatchesModel>> call([NoParam? param]) async {
    return await bookingRepo.getAvailableMatches(fieldId, date);
  }
}
