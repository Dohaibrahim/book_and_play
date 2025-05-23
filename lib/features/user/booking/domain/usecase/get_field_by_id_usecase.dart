import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/core/usecase/usecase.dart';
import 'package:book_and_play/features/user/booking/data/models/all_fields_res.dart';
import 'package:book_and_play/features/user/booking/domain/repo/booking_repo.dart';
import 'package:dartz/dartz.dart';

class GetFieldByIdUsecase extends UseCase<Field, NoParam> {
  final BookingRepo bookingRepo;
  final String id;
  GetFieldByIdUsecase({required this.bookingRepo, required this.id});

  @override
  Future<Either<Failure, Field>> call([NoParam? param]) async {
    return await bookingRepo.getFieldById(id);
  }
}
