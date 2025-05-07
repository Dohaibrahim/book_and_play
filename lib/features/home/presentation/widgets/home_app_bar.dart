import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
          Text(
            textAlign: TextAlign.start,
            'Doha',
            style: TextStyles.font14BlackMedium.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            // TextStyles.font24BlackBold
          ),
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
