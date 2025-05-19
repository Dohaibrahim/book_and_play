import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/core/utils/constant.dart';
import 'package:book_and_play/core/utils/shared_pref.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      //backgroundColor: Colors.white,
      centerTitle: false,
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Text(
            'Welcome Back,',
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
                  'Doha',
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
      actions: [
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
      ],
    );
  }
}
