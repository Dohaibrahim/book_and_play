import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final String hintText;
  final bool? isObscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? backgroundColor;
  final TextEditingController? controller;
  final Function(String?)? onSaved;
  final String? initialValue; // New nullable initialValue parameter
  final Color? fillColor;
  final BorderSide? focusedBorderSide, errorBorderSide, enabledBorderSide;
  const AppTextFormField({
    super.key,
    this.focusedBorder,
    this.focusedBorderSide,
    this.enabledBorderSide,
    this.errorBorderSide,
    this.enabledBorder,
    this.inputTextStyle,
    this.hintStyle,
    required this.hintText,
    this.fillColor,
    this.isObscureText,
    this.suffixIcon,
    this.backgroundColor,
    this.controller,
    this.prefixIcon,
    this.onSaved,
    this.initialValue, // Include initialValue in the constructor
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.green[800],
      controller: controller,
      initialValue: initialValue, // Set initialValue here
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide:
              focusedBorderSide ?? BorderSide(color: ColorManager.primaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: enabledBorderSide ?? BorderSide(color: Colors.grey[700]!),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: errorBorderSide ?? BorderSide(color: Colors.red),
        ),
        hintStyle: TextStyle(color: Colors.grey[700]),
        hintText: hintText,
        suffixIcon: suffixIcon,
        suffixIconColor: Colors.grey[700],
        fillColor: fillColor ?? Colors.transparent,
        //filled: true,
      ),
      obscuringCharacter: '*',
      obscureText: isObscureText ?? false,
      style: TextStyle(
        fontSize: 14,
        color: Colors.grey[700],
        fontWeight: FontWeight.w600,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'this field is required';
        }
        return null;
      },
      onSaved: onSaved,
    );
  }
}
