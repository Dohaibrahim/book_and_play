import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:flutter/material.dart';

class FieldAndMatchScore extends StatelessWidget {
  const FieldAndMatchScore({
    super.key,
    required this.screenWidth,
    required this.screenHight,
  });

  final double screenWidth;
  final double screenHight;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth * 0.85,
      height: screenHight * 0.11,
      decoration: BoxDecoration(
        color: Color(0xffE7EFFD),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.transparent),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //SizedBox(height: 8),
              Text(
                'Fields',
                style: TextStyles.font24BlackBold.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '2',
                style: TextStyles.font14BlackMedium.copyWith(fontSize: 18),
              ),

              //SizedBox(height: 10),
              //Text('2'),

              //Text('2'),
            ],
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: VerticalDivider(
              thickness: 1.5,
              color: ColorManager.textColor,
            ),
          ),
          //SizedBox(width: screenWidth * 0.30),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //SizedBox(height: 8),
              Text(
                'Matches',
                style: TextStyles.font24BlackBold.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '2',
                style: TextStyles.font14BlackMedium.copyWith(fontSize: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
