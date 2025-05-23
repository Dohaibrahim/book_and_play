import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/core/widgets/app_button.dart';
import 'package:flutter/material.dart';

class AppDialog extends StatelessWidget {
  const AppDialog({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.imagePath,
    required this.title,
    required this.subTitle,
  });

  final double screenHeight;
  final double screenWidth;
  final String imagePath, title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: screenHeight * 0.30,
        width: screenWidth * 0.80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.transparent),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              imagePath,
              width: 80,
              height: 80,
              color: ColorManager.primaryColor,
            ),
            SizedBox(height: screenHeight * 0.05),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyles.font24BlackBold.copyWith(
                color: ColorManager.primaryColor,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Text(
              subTitle,
              textAlign: TextAlign.center,
              style: TextStyles.font14BlackMedium,
            ),
            SizedBox(height: screenHeight * 0.01),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: AppButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                text: 'Okay',
                textColor: Colors.black,
                //buttonColor: Colors.grey[300],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
