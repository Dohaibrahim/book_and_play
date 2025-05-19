import 'dart:developer';

import 'package:book_and_play/core/routing/routes.dart';
import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/core/widgets/app_button.dart';
import 'package:book_and_play/features/booking/presentation/manager/fetch_field_by_id/fetch_field_by_id_cubit.dart';
import 'package:book_and_play/features/booking/presentation/manager/fetch_field_by_id/fetch_field_by_id_state.dart';
import 'package:book_and_play/features/booking/presentation/manager/fetch_fields_cubit/fetch_fields_cubit.dart';
import 'package:book_and_play/features/booking/presentation/widgets/location_button.dart';
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
          return Center(child: CircularProgressIndicator());
        } else if (state is FetchFieldByIdSuccessState) {
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
                    image: AssetImage('assets/images/stadium_image.jpg'),
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
                      /*SizedBox(
                    height: screenHeight * 0.07,
                    child: DataBookingSelection(),
                  ),*/
                      SizedBox(
                        height: screenHeight * 0.04,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Location Info :',
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
                        'Egypt 11371, Cairo, 69 Mostafa El Nahas Street, Nasr City',
                        style: TextStyles.font14BlackMedium.copyWith(
                          color: Colors.grey[700],
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      state.field.amenities.isNotEmpty
                          ? Text(
                            'Amenities :',
                            style: TextStyles.font24BlackBold,
                          )
                          : SizedBox(),
                      state.field.amenities.isNotEmpty
                          ? AmenitiesListView(amenties: state.field.amenities)
                          : SizedBox(),
                      Expanded(child: SizedBox()),
                      //Expanded(child: AvailableSlotsListView()),
                      AppButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.bookNowView);
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
  final List<dynamic> amenties;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: amenties.length,
      itemBuilder: (context, index) {
        return Text(
          amenties[index], // 'Toilets',
          style: TextStyles.font14BlackMedium.copyWith(
            color: Colors.grey[700],
            fontSize: 16,
          ),
        );
      },
    );
  }
}
