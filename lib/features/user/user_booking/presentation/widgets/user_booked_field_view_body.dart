import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/core/widgets/app_button.dart';
import 'package:book_and_play/features/user/user_booking/data/models/user_matches_res.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserBookedFieldViewBody extends StatelessWidget {
  const UserBookedFieldViewBody({super.key, required this.userMatchModel});
  final UserMatchModel userMatchModel;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final bool isMatchesOpen = userMatchModel.status == 'open';
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
                  child: Text(
                    userMatchModel.field.name,
                    style: TextStyles.font24BlackBold,
                  ),
                ),

                Text(
                  'A ${userMatchModel.field.capacity} x ${userMatchModel.field.capacity} Football Field',
                  style: TextStyles.font14BlackMedium.copyWith(
                    color: Colors.grey[700],
                    fontSize: 18,
                  ),
                ),
                Text(
                  '${userMatchModel.field.city} , ${userMatchModel.field.country} ',
                  style: TextStyles.font14BlackMedium.copyWith(
                    color: Colors.grey[700],
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  margin: EdgeInsets.symmetric(horizontal: 100),
                  height: 40,
                  decoration: BoxDecoration(
                    color: isMatchesOpen
                        ? ColorManager.primaryColor
                        : Colors.red,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      userMatchModel.status,
                      style: TextStyles.font24BlackBold.copyWith(
                        fontSize: 19,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
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
                          formatDayOfWeek(userMatchModel.date),
                          style: TextStyles.font24BlackBold.copyWith(
                            fontSize: 19,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.04),
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
                            '${formatTime(userMatchModel.time.start)} - ${formatTime(userMatchModel.time.end)}',
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
                Expanded(child: SizedBox()),
                AppButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  text: 'button.done'.tr(),
                ),
                SizedBox(height: screenHeight * 0.03),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String formatTime(String time24) {
    final inputFormat = DateFormat("HH:mm");
    final outputFormat = DateFormat("h:mm a"); // e.g. 6:00 PM

    final time = inputFormat.parse(time24);
    return outputFormat.format(time);
  }

  String formatDayOfWeek(DateTime date) {
    return DateFormat('EEEE').format(date); // Full day name
  }
}
