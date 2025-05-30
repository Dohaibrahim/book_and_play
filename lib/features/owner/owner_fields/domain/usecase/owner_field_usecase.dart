import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/core/usecase/usecase.dart';
import 'package:book_and_play/features/owner/owner_fields/data/models/owner_fields.dart';
import 'package:book_and_play/features/owner/owner_fields/domain/repo/owner_field_repo.dart';
import 'package:dartz/dartz.dart';

class OwnerFieldUsecase extends UseCase<List<OwnerField>, NoParam> {
  @override
  Future<Either<Failure, List<OwnerField>>> call([NoParam? param]) async {
    return await getIt<OwnerFieldRepo>().getOwnerFields();
  }
}
