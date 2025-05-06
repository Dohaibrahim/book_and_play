import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  const AppButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    final ScreenWidth = MediaQuery.sizeOf(context).width;
    return MaterialButton(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      textColor: Colors.white,
      color: ColorManager.primaryColor,
      minWidth: ScreenWidth * 0.80,
      onPressed: onPressed,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(color: Colors.transparent),
      ),
      child: Text(text),
    );
  }
}
