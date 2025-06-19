import 'package:book_and_play/features/owner/add_field/domain/usecase/get_places_usecase.dart';
import 'package:book_and_play/features/owner/add_field/presentation/manager/get_places_cubit/get_places_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetPlacesCubit extends Cubit<GetPlacesState> {
  GetPlacesCubit() : super(GetPlacesInitialState());

  Future<void> getPlaces(String query) async {
    emit(GetPlacesLoadingState());
    final result = await GetPlacesUsecase(query: query).call();
    result.fold(
      (failure) {
        emit(GetPlacesFailureState(errorMessage: failure.toString()));
      },
      (data) {
        emit(GetPlacesSuccessState(place: data.places));
      },
    );
  }
}
