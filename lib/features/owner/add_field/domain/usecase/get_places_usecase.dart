import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/core/errors/failure.dart';
import 'package:book_and_play/core/usecase/usecase.dart';
import 'package:book_and_play/features/owner/add_field/data/models/places_res.dart';
import 'package:book_and_play/features/owner/add_field/domain/repo/add_field_repo.dart';
import 'package:dartz/dartz.dart';

class GetPlacesUsecase extends UseCase<PlacesResponse, NoParam> {
  GetPlacesUsecase({required this.query});
  final String query;
  @override
  Future<Either<Failure, PlacesResponse>> call([NoParam? param]) async {
    return await getIt<AddFieldRepo>().getPlaces(query);
  }
}
