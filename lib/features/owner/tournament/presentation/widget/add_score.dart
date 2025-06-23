import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/core/widgets/app_button.dart';
import 'package:book_and_play/features/owner/tournament/presentation/widget/score_text_field.dart';
import 'package:flutter/material.dart';

class AddScore extends StatelessWidget {
  const AddScore({
    super.key,
    required this.initialScoreTeamA,
    required this.initialScoreTeamB,
  });
  final int? initialScoreTeamB, initialScoreTeamA;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      //height: 400,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.transparent),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Match Result',
            style: TextStyles.font24BlackBold.copyWith(fontSize: 18),
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Team A', style: TextStyles.font24BlackBold),
                  SizedBox(height: 40),
                  ScoreTextField(
                    onSaved: (data) {},
                    initialScoreTeamA: initialScoreTeamA,
                  ),
                ],
              ),
              Text(
                'VS',
                textAlign: TextAlign.end,
                style: TextStyles.font32BlockBold.copyWith(
                  color: ColorManager.primaryColor,
                  fontSize: 35,
                ),
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Team B', style: TextStyles.font24BlackBold),
                  SizedBox(height: 40),
                  ScoreTextField(
                    onSaved: (data) {},
                    initialScoreTeamA: initialScoreTeamB,
                  ),
                ],
              ),
            ],
          ),
          Expanded(child: SizedBox()),
          AppButton(
            height: 50,
            onPressed: () {},
            text: 'Add',
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
