import 'package:book_and_play/core/routing/routes.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/core/widgets/app_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class OnboardingViewBody extends StatelessWidget {
  const OnboardingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: screenHeight * 0.05),
          Image.asset('assets/images/onboarding_players.png'),
          SizedBox(height: screenHeight * 0.01),
          Center(
            child: Text(
              'onboarding.welcome'.tr(),
              style: TextStyles.font24BlackBold,
            ),
          ),
          Center(
            child: Text(
              'onboarding.subtitle'.tr(),
              textAlign: TextAlign.center,
              style: TextStyles.font14BlackMedium.copyWith(fontSize: 18),
            ),
          ),
          Image.asset(
            'assets/icons/onboarding_xo_icon.png',
            width: 100,
            height: 100,
          ),
          Expanded(child: SizedBox()),
          Center(
            child: Text(
              'onboarding.continue_as'.tr(),
              style: TextStyles.font14BlackMedium.copyWith(fontSize: 19),
            ),
          ),
          SizedBox(
            width: screenWidth * 0.70,
            height: 50,
            child: AppButton(
              //buttonWidth: screenWidth * 0.70,
              //height: 50,
              textStyle: TextStyles.font14BlackMedium.copyWith(
                color: Colors.white,
                fontSize: 17,
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  Routes.signUpView,
                  arguments: 'player',
                );
              },
              text: 'onboarding.player'.tr(),
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 50,
            width: screenWidth * 0.70,
            child: AppButton(
              //height: 50,
              //buttonWidth: screenWidth * 0.60,
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  Routes.signUpView,
                  arguments: 'owner',
                );
              },
              text: 'onboarding.owner'.tr(),
              buttonColor: Colors.blue[400],
              textStyle: TextStyles.font14BlackMedium.copyWith(
                color: Colors.white,
                fontSize: 17,
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.05),
        ],
      ),
    );
  }
}
