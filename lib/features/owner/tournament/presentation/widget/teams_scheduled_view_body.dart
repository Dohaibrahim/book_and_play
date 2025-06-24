import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/core/widgets/app_button.dart';
import 'package:book_and_play/features/owner/tournament/data/models/teams_matches_res.dart';
import 'package:book_and_play/features/owner/tournament/presentation/manager/get_matches/get_matches_cubit.dart';
import 'package:book_and_play/features/owner/tournament/presentation/manager/get_matches/get_matches_state.dart';
import 'package:book_and_play/features/owner/tournament/presentation/widget/add_score.dart';
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
                                return AddScore(
                                  teamA: currentMatches[index].teamA,
                                  teamB: currentMatches[index].teamB,
                                  initialScoreTeamA:
                                      currentMatches[index].score.teamA,
                                  initialScoreTeamB:
                                      currentMatches[index].score.teamB,
                                );
                              },
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            height: 170,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  'assets/images/match_card1.png',
                                ),
                              ),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.10),
                                  offset: Offset(0, 5),
                                  blurRadius: 8,
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              //crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  currentMatches[index].teamA.name,
                                  style: TextStyles.font24BlackBold.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      formatToReadableDate(
                                        currentMatches[index].date.toString(),
                                      ),
                                      style: TextStyles.font14BlackMedium
                                          .copyWith(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                    ),
                                    Text(
                                      '${currentMatches[index].time.start} : ${currentMatches[index].time.end}',
                                      style: TextStyles.font14BlackMedium
                                          .copyWith(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                    ),
                                    SizedBox(height: 1),
                                    Text(
                                      currentMatches[index].score.teamA != null
                                          ? '${currentMatches[index].score.teamA} - ${currentMatches[index].score.teamB}'
                                          : 'Add Score',
                                      style: TextStyles.font14BlackMedium
                                          .copyWith(
                                            color: Colors.white,
                                            fontSize: 19,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                    SizedBox(height: 20),
                                  ],
                                ),
                                Text(
                                  currentMatches[index].teamB.name,
                                  style: TextStyles.font24BlackBold.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                //Expanded(child: SizedBox()),
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






/*
Future<DateTime?> timeAndDatePicker(BuildContext context) async {
  DateTime? selectedDateTime;

  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now().subtract(Duration(days: 1)),
    lastDate: DateTime.now().add(Duration(days: 365)),
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          colorScheme: ColorScheme.dark(
            primary: ColorManager.primaryColor,
            onPrimary: Colors.black,
            surface: Colors.white,
            onSurface: Colors.black,
          ),
        ),
        child: child!,
      );
    },
  );

  if (pickedDate != null) {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: ColorManager.primaryColor,
              onPrimary: Colors.black,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      selectedDateTime = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );
    }
  }

  return selectedDateTime;
}
 */