import 'dart:developer';
import 'package:book_and_play/core/routing/routes.dart';
import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/core/widgets/app_button.dart';
import 'package:book_and_play/features/user/booking/data/models/all_fields_res.dart';
import 'package:book_and_play/features/user/booking/presentation/manager/fetch_field_by_id/fetch_field_by_id_cubit.dart';
import 'package:book_and_play/features/user/booking/presentation/manager/fetch_field_by_id/fetch_field_by_id_state.dart';
import 'package:book_and_play/features/user/booking/presentation/widgets/location_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FootballFieldViewBody extends StatelessWidget {
  const FootballFieldViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<FetchFieldByIdCubit>().getFieldById();
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;
    return BlocBuilder<FetchFieldByIdCubit, FetchFieldByIdState>(
      builder: (context, state) {
        if (state is FetchFieldByIdLoadingState) {
          return Center(
            child: CircularProgressIndicator(color: ColorManager.primaryColor),
          );
        } else if (state is FetchFieldByIdSuccessState) {
          final imageProvider =
              (state.field.image != null && state.field.image!.isNotEmpty)
              ? NetworkImage(state.field.image!)
              : AssetImage('assets/images/football_stadium_demo.jpg')
                    as ImageProvider;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: screenWidth,
                height: screenHeight * 0.45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: imageProvider,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  height: screenHeight * 0.55,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: screenHeight * 0.017),
                      SizedBox(
                        height: screenHeight * 0.04,
                        child: Text(
                          state.field.name, //'Red Meadow',
                          style: TextStyles.font24BlackBold,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: ColorManager.primaryColor,
                            size: 20,
                          ),
                          Text(
                            '${state.field.city} , ${state.field.country}', //' Cairo , Egypt',
                            style: TextStyles.font14BlackMedium.copyWith(
                              color: ColorManager.primaryColor,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      SizedBox(
                        height: screenHeight * 0.04,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'user_book.location_info'.tr(),
                              style: TextStyles.font24BlackBold,
                            ),
                            LocationButton(
                              latitude: state.field.location.coordinates[0],
                              longitude: state.field.location.coordinates[1],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        state.field.locationInfo ??
                            'No location description provided',
                        style: TextStyles.font14BlackMedium.copyWith(
                          color: Colors.grey[700],
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      state.field.amenities.isNotEmpty
                          ? Text(
                              'user_book.amenities'.tr(),
                              style: TextStyles.font24BlackBold,
                            )
                          : SizedBox(),
                      state.field.amenities.isNotEmpty
                          ? Expanded(
                              child: AmenitiesListView(
                                amenties: state.field.amenities,
                              ),
                            )
                          : SizedBox(),
                      Expanded(child: SizedBox()),
                      //Expanded(child: AvailableSlotsListView()),
                      AppButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            Routes.bookNowView,
                            arguments: {
                              'fieldName': state.field.name,
                              'fieldId': state.field.id,
                            },
                          );
                        },
                        text: 'Book Now',
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      //Expanded(child: SizedBox()),
                    ],
                  ),
                ),
              ),
            ],
          );
        } else if (state is FetchFieldByIdInitialState) {
          log('message');
        }
        return SizedBox();
      },
    );
  }
}

class AmenitiesListView extends StatelessWidget {
  const AmenitiesListView({super.key, required this.amenties});
  final List<Amenities> amenties;
  @override
  Widget build(BuildContext context) {
    final amenity = amenties.first;

    final available = {
      'Parking': amenity.parking,
      'Ball Rent': amenity.ballRent,
      'Toilets': amenity.toilets,
      'Changing Rooms': amenity.changingRooms,
      'Cafeteria': amenity.cafeteria,
      'Lighting Quality': amenity.lightingQuality,
      'Field Quality': amenity.fieldQuality,
    };

    final visibleAmenities = available.entries
        .where((entry) => entry.value!)
        .map((entry) => entry.key)
        .toList();

    return SizedBox(
      height: 100,
      child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: amenties.length,
        itemBuilder: (context, index) {
          return Text(
            visibleAmenities[index],
            style: TextStyles.font14BlackMedium.copyWith(
              color: Colors.grey[700],
              fontSize: 16,
            ),
          );
        },
      ),
    );
  }
}
