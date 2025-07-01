import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/core/usecase/usecase.dart';
import 'package:book_and_play/features/owner/owner_fields/data/models/delete_field_res.dart';
import 'package:book_and_play/features/owner/owner_fields/domain/repo/owner_field_repo.dart';
import 'package:dartz/dartz.dart';

class DeleteFieldUsecase extends UseCase<DeletedFieldResponse, NoParam> {
  final String fieldId;
  DeleteFieldUsecase({required this.fieldId});
  @override
  Future<Either<Failure, DeletedFieldResponse>> call([NoParam? param]) async {
    return await getIt<OwnerFieldRepo>().deleteField(fieldId);
  }
}
