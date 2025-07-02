import 'package:book_and_play/core/widgets/app_text_form_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BookingSearchBar extends StatelessWidget {
  const BookingSearchBar({
    super.key,
    required this.screenHeight,
    required this.controller,
  });

  final double screenHeight;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeight * 0.05,
      child: AppTextFormField(
        controller: controller,
        fillColor: Colors.grey[700],
        hintText: 'user_book.search_hint'.tr(),
        suffixIcon: Icon(Icons.search, size: 25),
        focusedBorderSide: BorderSide(color: Colors.grey[400]!),
        enabledBorderSide: BorderSide(color: Colors.grey[200]!),
        errorBorderSide: BorderSide(color: Colors.red),
      ),
    );
  }
}
