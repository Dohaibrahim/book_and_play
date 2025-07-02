import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/core/utils/constant.dart';
import 'package:book_and_play/core/utils/shared_pref.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      forceMaterialTransparency: true,
      shadowColor: Colors.transparent,
      centerTitle: false,
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Text(
            'player_home_appbar.welcome_back'.tr(),
            style: TextStyles.font14BlackMedium.copyWith(
              fontSize: 18,
              color: Colors.grey[700],
            ),
            // TextStyles.font24BlackBold
          ),
          FutureBuilder(
            future: SharedPrefHelper.getStringNullable(SharedPrefKeys.username),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Error: ${snapshot.error}',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                );
              } else {
                String userName = snapshot.data ?? 'User';
                return Text(
                  textAlign: TextAlign.start,
                  userName,
                  style: TextStyles.font14BlackMedium.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                );
              }
            },
          ),

          // TextStyles.font24BlackBold
        ],
      ),
      /*actions: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey[700],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  child: ImageIcon(
                    color: Colors.white,
                    AssetImage('assets/icons/share.png'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],*/
    );
  }
}
