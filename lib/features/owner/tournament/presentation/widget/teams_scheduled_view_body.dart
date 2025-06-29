import 'dart:developer';

import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/core/widgets/app_button.dart';
import 'package:book_and_play/features/owner/tournament/data/models/teams_matches_res.dart';
import 'package:book_and_play/features/owner/tournament/presentation/manager/get_matches/get_matches_cubit.dart';
import 'package:book_and_play/features/owner/tournament/presentation/manager/get_matches/get_matches_state.dart';
import 'package:book_and_play/features/owner/tournament/presentation/widget/add_score.dart';
import 'package:book_and_play/features/owner/tournament/presentation/widget/match_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TeamsScheduledViewBody extends StatefulWidget {
  const TeamsScheduledViewBody({super.key, required this.id});
  final String id;
  @override
  State<TeamsScheduledViewBody> createState() => _TeamsScheduledViewBodyState();
}

class _TeamsScheduledViewBodyState extends State<TeamsScheduledViewBody> {
  DateTime? pickedStartDate, pickedEndDate;
  @override
  Widget build(BuildContext context) {
    context.read<GetMatchesCubit>().getMatches(widget.id);
    final screenHeight = MediaQuery.sizeOf(context).height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: BlocBuilder<GetMatchesCubit, GetMatchesState>(
        builder: (context, state) {
          if (state is GetMatchesFailureState) {
            return Center(
              child: Text(
                'Error : ${state.errorMsg}',
                style: TextStyles.font14BlackMedium,
              ),
            );
          }
          if (state is GetMatchesLoadingState) {
            return Center(
              child: CircularProgressIndicator(
                color: ColorManager.primaryColor,
              ),
            );
          }
          if (state is GetMatchesSuccessState) {
            List<MatchScheduled> currentMatches = [];
            if (state.rounds.finalRound.isNotEmpty) {
              currentMatches = state.rounds.finalRound;
            } else if (state.rounds.semifinal.isNotEmpty) {
              currentMatches = state.rounds.semifinal;
            } else if (state.rounds.quarterfinal.isNotEmpty) {
              currentMatches = state.rounds.quarterfinal;
            } else if (state.rounds.roundOf16.isNotEmpty) {
              currentMatches = state.rounds.roundOf16;
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: screenHeight * 0.10),
                Text(
                  currentMatches[0].round,
                  style: TextStyles.font32BlockBold,
                ),
                SizedBox(height: 15),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: currentMatches.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: GestureDetector(
                          onTap: () async {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                log(currentMatches[index].id);
                                return AddScore(
                                  matchId: currentMatches[index].id,
                                  teamA: currentMatches[index].teamA,
                                  teamB: currentMatches[index].teamB,
                                  initialScoreTeamA:
                                      currentMatches[index].score.teamA ?? 0,
                                  initialScoreTeamB:
                                      currentMatches[index].score.teamB ?? 0,
                                );
                              },
                            );
                          },
                          child: MatchCard(
                            teamsAName: currentMatches[index].teamA.name,
                            date: formatToReadableDate(
                              currentMatches[index].date.toString(),
                            ),
                            time:
                                '${currentMatches[index].time.start} : ${currentMatches[index].time.end}',
                            score: currentMatches[index].score.teamA != null
                                ? '${currentMatches[index].score.teamA} - ${currentMatches[index].score.teamB}'
                                : 'Add Score',
                            teamsBName: currentMatches[index].teamB.name,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                AppButton(
                  onPressed: () {},
                  text: 'Start first round of matches',
                ),
                SizedBox(height: screenHeight * 0.05),
              ],
            );
          }
          return SizedBox();
        },
      ),
    );
  }

  String formatToReadableDate(String isoDate) {
    final date = DateTime.parse(isoDate);
    final formatter = DateFormat('d MMMM');
    return formatter.format(date);
  }
}
