import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/core/usecase/usecase.dart';
import 'package:book_and_play/features/owner/add_field/data/models/add_field_req.dart';
import 'package:book_and_play/features/owner/add_field/data/models/field_creation_res.dart';
import 'package:book_and_play/features/owner/add_field/domain/repo/add_field_repo.dart';
import 'package:dartz/dartz.dart';

class AddFieldUsecase extends UseCase<FieldCreationResponse, AddFieldRequest> {
  @override
  Future<Either<Failure, FieldCreationResponse>> call([
    AddFieldRequest? param,
  ]) async {
    return await getIt<AddFieldRepo>().createField(param!);
  }
}
