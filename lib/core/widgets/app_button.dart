import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final Color? buttonColor, textColor;
  final double? buttonWidth;
  const AppButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.buttonColor,
    this.textColor,
    this.buttonWidth,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return MaterialButton(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      textColor: textColor ?? Colors.white,
      color: buttonColor ?? ColorManager.primaryColor,
      minWidth: buttonWidth ?? screenWidth * 0.80,
      onPressed: onPressed,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(color: Colors.transparent),
      ),
      child: Text(text),
    );
  }
}
