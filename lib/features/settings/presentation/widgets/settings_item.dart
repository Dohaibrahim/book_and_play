import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:flutter/material.dart';

class SettingsIcon extends StatelessWidget {
  const SettingsIcon({
    super.key,
    required this.screenHeight,
    required this.text,
    required this.onTap,
  });

  final double screenHeight;
  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: screenHeight * 0.01,
      ),
      height: screenHeight * 0.056,
      decoration: BoxDecoration(
        color: Color(0xffE7EFFD),
        border: Border.all(color: Colors.transparent),
        borderRadius: BorderRadius.circular(10),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          text,
          style: TextStyles.font14BlackMedium.copyWith(fontSize: 18),
        ),
      ),
    );
  }
}
