import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:flutter/material.dart';

class ScoreTextField extends StatelessWidget {
  const ScoreTextField({
    super.key,
    required this.onSaved,
    required this.initialScoreTeamA,
  });

  final void Function(String? p1)? onSaved;
  final int? initialScoreTeamA;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 60,
      child: TextFormField(
        textAlign: TextAlign.center,
        onSaved: onSaved,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        keyboardType: TextInputType.number,
        initialValue: initialScoreTeamA?.toString() ?? '0',
        decoration: InputDecoration(
          hintStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          fillColor: Colors.grey[300],
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorManager.primaryColor),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
