import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/features/booking/domain/usecase/fetch_fields_usecase.dart';
import 'package:book_and_play/features/booking/presentation/manager/fetch_fields_cubit/fetch_fields_cubit.dart';
import 'package:book_and_play/features/booking/presentation/widgets/booking_search_bar.dart';
import 'package:book_and_play/features/booking/presentation/widgets/choose_football_field_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChooseFootballFieldView extends StatelessWidget {
  const ChooseFootballFieldView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;
    return BlocProvider(
      create:
          (context) =>
              FetchFieldsCubit(fetchFieldsUsecase: getIt<FetchFieldsUsecase>()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Browse Football Fields',
            style: TextStyles.font24BlackBold.copyWith(fontSize: 22),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              BookingSearchBar(screenHeight: screenHeight),
              SizedBox(height: screenHeight * 0.01),
              /*SizedBox(
                width: screenWidth,
                height: screenHeight * 0.025,
                child: Text(
                  textAlign: TextAlign.end,
                  'Search by Location',
                  style: TextStyles.font14BlackMedium.copyWith(
                    color: ColorManager.primaryColor,
                    fontSize: 15,
                  ),
                ),
              ),*/
              SizedBox(
                height: screenHeight * 0.77,
                child: ChooseFootballFieldViewBody(),
              ),

              /*
              AppButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.bookingView);
                },
                text: 'Search By Location',
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
