import 'package:book_and_play/core/routing/routes.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/core/utils/constant.dart';
import 'package:book_and_play/core/utils/shared_pref.dart';
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
                height: screenHeight * 0.25,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Image.asset(
                      'assets/icons/soccer_player.png',
                      width: 100,
                      height: 100,
                    ),
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
                            fontSize: 22,
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
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: screenHeight * 0.01,
                  ),
                  height: screenHeight * 0.056,
                  //width: screenWidth * 0.80,
                  decoration: BoxDecoration(
                    color: Color(0xffE7EFFD),
                    border: Border.all(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: GestureDetector(
                    child: Text(
                      'log out',
                      style: TextStyles.font14BlackMedium.copyWith(
                        fontSize: 18,
                      ),
                    ),
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
                  ),
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
