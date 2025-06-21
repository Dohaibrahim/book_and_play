import 'package:book_and_play/core/routing/routes.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/core/utils/constant.dart';
import 'package:book_and_play/core/utils/shared_pref.dart';
import 'package:book_and_play/features/user/settings/presentation/widgets/settings_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SettingsViewBody extends StatelessWidget {
  const SettingsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;
    return FutureBuilder<Map<String, String?>>(
      future: _getUserInfo(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final userInfo =
              snapshot.data ??
              {'username': 'User', 'email': 'user@example.com'};
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: screenHeight * 0.23,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(width: screenWidth * 0.10),
                    Image.asset(
                      'assets/icons/soccer_player.png',
                      width: 80,
                      height: 80,
                    ),
                    SizedBox(width: screenWidth * 0.05),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '${userInfo['username']}',
                          style: TextStyles.font24BlackBold.copyWith(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '${userInfo['email']}',
                          style: TextStyles.font24BlackBold.copyWith(
                            fontSize: 19,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(color: Colors.grey, thickness: 1),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SettingsIcon(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.aboutUsView);
                      },
                      screenHeight: screenHeight,
                      text: 'user_settings.about_us'.tr(),
                    ),
                    SizedBox(height: screenHeight * 0.017),
                    SettingsIcon(
                      screenHeight: screenHeight,
                      text: 'user_settings.change_password'.tr(),
                      onTap: () {},
                    ),
                    SizedBox(height: screenHeight * 0.017),
                    SettingsIcon(
                      onTap: () async {
                        await SharedPrefHelper.removeData(
                          SharedPrefKeys.userToken,
                        );
                        await SharedPrefHelper.clearAllData();
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          Routes.onboardingView,
                          (Route<dynamic> route) => false,
                        );
                      },
                      screenHeight: screenHeight,
                      text: 'user_settings.logout'.tr(),
                    ),
                    SizedBox(height: screenHeight * 0.017),
                  ],
                ),
              ),
            ],
          );
        }
      },
    );
  }
}

Future<Map<String, String?>> _getUserInfo() async {
  final username = await SharedPrefHelper.getStringNullable(
    SharedPrefKeys.username,
  );
  final email = await SharedPrefHelper.getStringNullable(
    SharedPrefKeys.userEmail,
  );
  return {'username': username, 'email': email};
}
