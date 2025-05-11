import 'package:book_and_play/core/routing/routes.dart';
import 'package:book_and_play/core/widgets/app_button.dart';
import 'package:book_and_play/features/booking/presentation/widgets/choose_football_field_view_body.dart';
import 'package:flutter/material.dart';

class ChooseFootballFieldView extends StatelessWidget {
  const ChooseFootballFieldView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
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
              height: screenHeight * 0.80,
              child: ChooseFootballFieldViewBody(),
            ),
            AppButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.bookingView);
              },
              text: 'Search By Location',
            ),
          ],
        ),
      ),
    );
  }
}
