import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/core/utils/constant.dart';
import 'package:book_and_play/core/utils/shared_pref.dart';
import 'package:flutter/material.dart';

class SettingsViewBody extends StatelessWidget {
  const SettingsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
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
