import 'package:flutter/material.dart';

class PrivatePublicCheckBox extends StatelessWidget {
  const PrivatePublicCheckBox({
    super.key,
    required this.onChanged,
    required this.screenWidth,
    required this.value,
    required this.text,
  });
  final double screenWidth;
  final bool? value;
  final void Function(bool?)? onChanged;
  final String text;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidth * 0.40,
      child: CheckboxListTile(
        checkColor: Colors.transparent,
        side: const BorderSide(color: Colors.grey),
        activeColor: const Color(0xff58997F),
        checkboxShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 32),
        title: Text(text),
        value: value,
        onChanged: onChanged,

        /*(value) {
          setState(() {
            isASelected = true;
            isBSelected = false;
          });
        },*/
      ),
    );
  }
}
