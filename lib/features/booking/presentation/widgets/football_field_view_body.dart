import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/core/widgets/app_button.dart';
import 'package:book_and_play/features/booking/presentation/widgets/available_slots.dart';
import 'package:book_and_play/features/booking/presentation/widgets/data_bokking_selection.dart';
import 'package:flutter/material.dart';

class FootballFieldViewBody extends StatelessWidget {
  const FootballFieldViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          width: screenWidth,
          height: screenHeight * 0.30,
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
            height: screenHeight * 0.70,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: screenHeight * 0.01),
                SizedBox(
                  height: screenHeight * 0.04,
                  child: Text('Red Meadow', style: TextStyles.font24BlackBold),
                ),
                SizedBox(
                  height: screenHeight * 0.07,
                  child: DataBookingSelection(),
                ),
                Text(
                  'A 5x5 Football Field',
                  style: TextStyles.font14BlackMedium.copyWith(
                    color: Colors.grey[700],
                    fontSize: 18,
                  ),
                ),
                Text(
                  'Cairo , egypt , 1 km away',
                  style: TextStyles.font14BlackMedium.copyWith(
                    color: Colors.grey[700],
                    fontSize: 18,
                  ),
                ),

                Expanded(child: AvailableSlotsListView()),
                AppButton(onPressed: () {}, text: 'Book Now'),
                SizedBox(height: screenHeight * 0.03),
                //Expanded(child: SizedBox()),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
