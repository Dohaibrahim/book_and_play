import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/core/usecase/usecase.dart';
import 'package:book_and_play/features/booking/data/models/all_fields_res.dart';
import 'package:book_and_play/features/booking/domain/repo/booking_repo.dart';
import 'package:dartz/dartz.dart';

class FetchFieldsUsecase extends UseCase<List<Field>, NoParam> {
  final BookingRepo allFieldsRepo;

  FetchFieldsUsecase({required this.allFieldsRepo});
  @override
  Future<Either<Failure, List<Field>>> call([NoParam? param]) async {
    return await allFieldsRepo.fetchFields();
  }
}
