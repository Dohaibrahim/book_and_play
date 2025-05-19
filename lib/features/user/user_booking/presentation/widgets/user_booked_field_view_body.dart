import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/core/widgets/app_button.dart';
import 'package:flutter/material.dart';

class UserBookedFieldViewBody extends StatelessWidget {
  const UserBookedFieldViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          width: screenWidth,
          height: screenHeight * 0.50,
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
            height: screenHeight * 0.50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: screenHeight * 0.01),
                SizedBox(
                  height: screenHeight * 0.04,
                  child: Text('Red Meadow', style: TextStyles.font24BlackBold),
                ),

                Text(
                  'A 5x5 Football Field',
                  style: TextStyles.font14BlackMedium.copyWith(
                    color: Colors.grey[700],
                    fontSize: 18,
                  ),
                ),
                Text(
                  'Cairo , egypt ',
                  style: TextStyles.font14BlackMedium.copyWith(
                    color: Colors.grey[700],
                    fontSize: 18,
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      height: 40,
                      decoration: BoxDecoration(
                        color: ColorManager.primaryColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          'Friday',
                          style: TextStyles.font24BlackBold.copyWith(
                            fontSize: 19,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.05),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        height: 40,
                        decoration: BoxDecoration(
                          color: ColorManager.primaryColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                            '7:00 - 8:00 am',
                            style: TextStyles.font24BlackBold.copyWith(
                              fontSize: 19,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                /*Text(
                  '1 km away',
                  style: TextStyles.font14BlackMedium.copyWith(
                    color: Colors.grey[700],
                    fontSize: 18,
                  ),
                ),*/
                Expanded(child: SizedBox()),
                AppButton(onPressed: () {}, text: 'Review Your Booking '),
                SizedBox(height: screenHeight * 0.03),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
