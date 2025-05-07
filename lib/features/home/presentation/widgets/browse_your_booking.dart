import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:flutter/material.dart';

class BrowseYourBooking extends StatelessWidget {
  const BrowseYourBooking({
    super.key,
    required this.title,
    this.trailing,
    this.onTap,
  });
  final String title;
  final Widget? trailing;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final screenHight = MediaQuery.sizeOf(context).height;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
        height: screenHight * 0.08,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              offset: Offset(0, 8),
              blurRadius: 8,
              spreadRadius: 0,
            ),
          ],
          borderRadius: BorderRadius.circular(15),
          color: Color(0xffE7EFFD), //  ColorManager.primaryColor,
        ),
        child: ListTile(
          titleAlignment: ListTileTitleAlignment.titleHeight,
          title: Text(
            title,
            textAlign: TextAlign.start,
            style: TextStyles.font24BlackBold.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          trailing: trailing,
        ),
      ),
    );
  }
}
