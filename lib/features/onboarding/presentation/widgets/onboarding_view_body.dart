import 'package:book_and_play/core/routing/routes.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/core/widgets/app_button.dart';
import 'package:flutter/material.dart';

class OnboardingViewBody extends StatelessWidget {
  const OnboardingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: screenHeight * 0.20),
          Image.asset('assets/images/onboarding_image.png'),
          SizedBox(height: 50),
          Center(
            child: Text(
              'Welcome to Book and Play!',
              style: TextStyles.font24BlackBold,
            ),
          ),
          /*Center(
            child: Text(
              'Continue as ',
              style: TextStyles.font24BlackBold.copyWith(
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),*/
          Expanded(child: SizedBox()),
          AppButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, Routes.signUpView);
            },
            text: 'Continue as Player',
          ),
          AppButton(
            onPressed: () {},
            text: 'Continue as Football Field Owner',
            buttonColor: Colors.blue[400],
          ),
          SizedBox(height: screenHeight * 0.05),
        ],
      ),
    );
  }
}
