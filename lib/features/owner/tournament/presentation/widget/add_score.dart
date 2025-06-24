import 'dart:developer';

import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/core/widgets/app_button.dart';
import 'package:book_and_play/features/owner/tournament/data/models/teams_matches_res.dart';
import 'package:book_and_play/features/owner/tournament/presentation/widget/score_text_field.dart';
import 'package:flutter/material.dart';

class AddScore extends StatefulWidget {
  const AddScore({
    super.key,
    required this.initialScoreTeamA,
    required this.initialScoreTeamB,
    required this.teamA,
    required this.teamB,
    required this.matchId,
  });
  final int? initialScoreTeamB, initialScoreTeamA;
  final Team teamA, teamB;
  final String matchId;

  @override
  State<AddScore> createState() => _AddScoreState();
}

class _AddScoreState extends State<AddScore> {
  String? scoreForA;
  String? scoreForB;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  void initState() {
    super.initState();
    scoreForA = widget.initialScoreTeamA?.toString();
    scoreForB = widget.initialScoreTeamB?.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
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
          Form(
            autovalidateMode: autovalidateMode,
            key: formKey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(widget.teamA.name, style: TextStyles.font24BlackBold),
                    SizedBox(height: 40),
                    ScoreTextField(
                      onSaved: (data) {
                        scoreForA = data;
                      },
                      initialScoreTeamA: widget.initialScoreTeamA,
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
                    Text(widget.teamB.name, style: TextStyles.font24BlackBold),
                    SizedBox(height: 40),
                    ScoreTextField(
                      onSaved: (data) {
                        scoreForB = data;
                      },
                      initialScoreTeamA: widget.initialScoreTeamB,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(child: SizedBox()),
          AppButton(
            height: 50,
            onPressed: () {
              formKey.currentState!.save();
              log('${scoreForA} , ${scoreForB}');
              log(widget.teamA.id);
            },
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
