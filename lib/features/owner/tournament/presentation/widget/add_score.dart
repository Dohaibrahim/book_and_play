import 'dart:developer';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/core/widgets/app_button.dart';
import 'package:book_and_play/core/widgets/top_snackbar.dart';
import 'package:book_and_play/features/owner/tournament/data/models/add_score_req.dart';
import 'package:book_and_play/features/owner/tournament/data/models/teams_matches_res.dart';
import 'package:book_and_play/features/owner/tournament/presentation/manager/add_score_cubit/add_score_cubit.dart';
import 'package:book_and_play/features/owner/tournament/presentation/manager/add_score_cubit/add_score_state.dart';
import 'package:book_and_play/features/owner/tournament/presentation/widget/score_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BlocProvider(
      create: (context) => AddScoreCubit(),
      child: Container(
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
                      Text(
                        widget.teamA.name,
                        style: TextStyles.font24BlackBold,
                      ),
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
                      Text(
                        widget.teamB.name,
                        style: TextStyles.font24BlackBold,
                      ),
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
            BlocConsumer<AddScoreCubit, AddScoreState>(
              listener: (context, state) {
                if (state is AddScoreFailureState) {
                  return TopSnackBar.show(
                    context,
                    title: 'Error',
                    message: state.msg,
                    contentType: ContentType.failure,
                    color: Colors.red,
                  );
                }
                if (state is AddScoreSuccessState) {
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                if (state is AddScoreLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: ColorManager.primaryColor,
                    ),
                  );
                }

                return AppButton(
                  height: 50,
                  onPressed: () {
                    log('${widget.matchId}');
                    log(int.parse(scoreForA!).toString());
                    log(int.parse(scoreForB!).toString());
                    formKey.currentState!.save();
                    if (int.parse(scoreForA!) != int.parse(scoreForB!)) {
                      var winnerId =
                          int.parse(scoreForA!) > int.parse(scoreForB!)
                          ? widget.teamA.id
                          : widget.teamB.id;
                      log('winner id : ${winnerId}');
                      log(widget.teamA.id);
                      context.read<AddScoreCubit>().addScore(
                        widget.matchId,
                        AddScoreReq(
                          scoreA: int.parse(scoreForA!),
                          scoreB: int.parse(scoreForB!),
                          winnerId: winnerId,
                        ),
                      );
                    } else {
                      log('score a : ${scoreForA} , score b : ${scoreForB}');
                      TopSnackBar.show(
                        context,
                        title: 'Warning',
                        message:
                            'You should add score first and they shouldn\'t equal',
                        contentType: ContentType.warning,
                        color: Colors.orange,
                      );
                    }
                  },
                  text: 'Add',
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
