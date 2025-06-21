import 'dart:developer';

import 'package:book_and_play/features/owner/add_field/presentation/manager/get_places_cubit/get_places_cubit.dart';
import 'package:book_and_play/features/owner/add_field/presentation/manager/get_places_cubit/get_places_state.dart';
import 'package:book_and_play/features/owner/add_field/presentation/widgets/search_on_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchBarBlocBuilder extends StatefulWidget {
  const SearchBarBlocBuilder({
    super.key,
    required this.searchController,
    required this.googleMapController,
  });

  final TextEditingController searchController;
  final GoogleMapController? googleMapController;

  @override
  State<SearchBarBlocBuilder> createState() => _SearchBarBlocBuilderState();
}

class _SearchBarBlocBuilderState extends State<SearchBarBlocBuilder> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          BlocBuilder<GetPlacesCubit, GetPlacesState>(
            builder: (context, state) {
              return CustomSearchBar(
                controller: widget.searchController,
                onChanged: (value) {
                  context.read<GetPlacesCubit>().getPlaces(value);
                  log('User typed: $value');
                },
                onClear: () {
                  widget.searchController.clear();
                  setState(() {});
                },
              );
            },
          ),

          BlocBuilder<GetPlacesCubit, GetPlacesState>(
            builder: (context, state) {
              if (state is GetPlacesLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is GetPlacesSuccessState) {
                if (widget.searchController.text.isEmpty) {
                  return SizedBox();
                }
                //top: 60,
                //left: 16,
                //right: 16,
                //bottom: 0,
                return SizedBox(
                  height: 500,
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    itemCount: state.place.length > 5 ? 5 : state.place.length,
                    itemBuilder: (context, index) {
                      final place = state.place[index];
                      return SizedBox(
                        height: 90,
                        child: GestureDetector(
                          onTap: () {
                            widget.googleMapController?.animateCamera(
                              CameraUpdate.newLatLng(
                                LatLng(place.location.lat, place.location.lng),
                              ),
                            );
                            widget.searchController.clear();
                            setState(() {});
                          },
                          child: Card(
                            margin: EdgeInsets.only(bottom: 10),
                            child: ListTile(
                              title: Text(place.name),
                              subtitle: Text(
                                place.address,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else if (state is GetPlacesFailureState) {
                return SizedBox();
              } else {
                return const SizedBox(); // Initial state or empty
              }
            },
          ),
        ],
      ),
    );
  }
}
