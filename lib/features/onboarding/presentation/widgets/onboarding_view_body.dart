import 'package:book_and_play/core/routing/routes.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/core/widgets/app_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class OnboardingViewBody extends StatefulWidget {
  const OnboardingViewBody({super.key});

  @override
  State<OnboardingViewBody> createState() => _OnboardingViewBodyState();
}

class _OnboardingViewBodyState extends State<OnboardingViewBody> {
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
              textStyle: TextStyles.font14BlackMedium.copyWith(
                color: Colors.white,
                fontSize: 17,
              ),
              onPressed: () {
                Navigator.pushNamed(
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
              onPressed: () {
                Navigator.pushNamed(
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
          AppButton(
            onPressed: () {
              showBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey[200]!),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    height: screenHeight * 0.45,
                    child: Padding(
                      padding: EdgeInsetsGeometry.symmetric(
                        horizontal: 20,
                        vertical: 50,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          AppButton(
                            onPressed: () async {
                              Navigator.pop(context);
                              context.setLocale(Locale('ar'));
                              setState(() {});
                            },
                            text: 'arabic',
                          ),
                          AppButton(
                            onPressed: () async {
                              Navigator.pop(context);
                              context.setLocale(Locale('zh'));
                              setState(() {});
                            },
                            text: 'Chinese',
                          ),
                          AppButton(
                            onPressed: () {
                              context.setLocale(Locale('en'));
                              print('Switched to: ${context.locale}');
                              Navigator.pop(context);
                              setState(() {});
                            },
                            text: 'english',
                          ),
                          AppButton(
                            onPressed: () async {
                              Navigator.pop(context);
                              context.setLocale(Locale('fr'));
                              setState(() {});
                            },
                            text: 'Frensh',
                          ),
                          AppButton(
                            onPressed: () async {
                              Navigator.pop(context);
                              context.setLocale(Locale('it'));
                              setState(() {});
                            },
                            text: 'Italian',
                          ),
                          AppButton(
                            onPressed: () async {
                              Navigator.pop(context);
                              context.setLocale(Locale('pt'));
                              setState(() {});
                            },
                            text: 'Portuguese',
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            text: 'Language',
            height: 50,
            textStyle: TextStyle(fontSize: 18),
          ),
          SizedBox(height: screenHeight * 0.05),
        ],
      ),
    );
  }
}

class ChangeLanguage extends StatefulWidget {
  const ChangeLanguage({
    super.key,
    required this.screenHeight,
    required this.context,
  });
  final BuildContext context;
  final double screenHeight;

  @override
  State<ChangeLanguage> createState() => _ChangeLanguageState();
}

class _ChangeLanguageState extends State<ChangeLanguage> {
  @override
  Widget build(BuildContext newcontext) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[200]!),
        borderRadius: BorderRadius.circular(25),
      ),
      height: widget.screenHeight * 0.45,
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 20, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppButton(
              onPressed: () async {
                Navigator.pop(widget.context);
                widget.context.setLocale(Locale('ar'));
                setState(() {});
              },
              text: 'arabic',
            ),
            AppButton(
              onPressed: () async {
                Navigator.pop(widget.context);
                widget.context.setLocale(Locale('zh'));
                setState(() {});
              },
              text: 'Chinese',
            ),
            AppButton(
              onPressed: () {
                widget.context.setLocale(Locale('en'));

                Navigator.pop(widget.context);
                setState(() {});
              },
              text: 'english',
            ),
            AppButton(
              onPressed: () async {
                Navigator.pop(widget.context);
                widget.context.setLocale(Locale('fr'));
                setState(() {});
              },
              text: 'Frensh',
            ),
            AppButton(
              onPressed: () async {
                Navigator.pop(widget.context);
                widget.context.setLocale(Locale('it'));
                setState(() {});
              },
              text: 'Italian',
            ),
            AppButton(
              onPressed: () async {
                Navigator.pop(widget.context);
                widget.context.setLocale(Locale('pt'));
                setState(() {});
              },
              text: 'Portuguese',
            ),
          ],
        ),
      ),
    );
  }
}
