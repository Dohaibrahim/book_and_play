import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/core/widgets/app_button.dart';
import 'package:book_and_play/core/widgets/top_snackbar.dart';
import 'package:book_and_play/features/owner/tournament/presentation/manager/generate_next_round_cubit/generate_next_round_cubit.dart';
import 'package:book_and_play/features/owner/tournament/presentation/manager/generate_next_round_cubit/generate_next_round_state.dart';
import 'package:book_and_play/features/owner/tournament/presentation/manager/get_tournaments_teams/get_tournaments_teams_cubit.dart';
import 'package:book_and_play/features/owner/tournament/presentation/manager/get_tournaments_teams/get_tournaments_teams_state.dart';
import 'package:book_and_play/features/owner/tournament/presentation/widget/generate_next_round.dart';
import 'package:book_and_play/features/owner/tournament/presentation/widget/teams_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeamsJoinedViewBody extends StatefulWidget {
  const TeamsJoinedViewBody({
    super.key,
    required this.id,
    required this.teamsNum,
  });
  final String id;
  final int? teamsNum;
  @override
  State<TeamsJoinedViewBody> createState() => _TeamsJoinedViewBodyState();
}

class _TeamsJoinedViewBodyState extends State<TeamsJoinedViewBody> {
  bool isTeamsEmpty = true;
  @override
  Widget build(BuildContext context) {
    context.read<GetTournamentsTeamsCubit>().getTeams(widget.id);
    final screenHeight = MediaQuery.sizeOf(context).height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: screenHeight * 0.10),
          Text('teams_joined.title'.tr(), style: TextStyles.font32BlockBold),
          SizedBox(height: 15),
          BlocBuilder<GetTournamentsTeamsCubit, GetTournamentsTeamsState>(
            builder: (context, state) {
              if (state is GetTournamentsTeamsLoadingState) {
                return Expanded(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: ColorManager.primaryColor,
                    ),
                  ),
                );
              }
              if (state is GetTournamentsTeamsFailureState) {
                return Expanded(
                  child: Center(child: Text('teams_joined.error'.tr())),
                );
              }
              if (state is GetTournamentsTeamsSuccessState) {
                var teams = state.teams;
                if (teams.isEmpty) {
                  return Expanded(
                    child: Center(
                      child: Text(
                        'There are no teams joined yet',
                        style: TextStyles.font14BlackMedium,
                      ),
                    ),
                  );
                }
                isTeamsEmpty = false;
                return Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      var formattedDate = formatDate(teams[index].createdAt);
                      return TeamCard(
                        subTitle: formattedDate,
                        title: teams[index].name,
                      );
                    },
                    itemCount: teams.length,
                  ),
                );
              }
              return SizedBox();
            },
          ),
          SizedBox(height: screenHeight * 0.005),
          isTeamsEmpty == false
              ? BottomSheetBuilder(widget: widget, teamsNum: widget.teamsNum)
              : SizedBox(),
          SizedBox(height: screenHeight * 0.05),
        ],
      ),
    );
  }

  String formatDate(DateTime date) {
    return DateFormat('d MMMM yyyy').format(date);
  }
}

class BottomSheetBuilder extends StatelessWidget {
  const BottomSheetBuilder({
    super.key,
    required this.widget,
    required this.teamsNum,
  });

  final TeamsJoinedViewBody widget;
  final int? teamsNum;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (innerContext) => AppButton(
        onPressed: () {
          showModalBottomSheet(
            context: innerContext,
            backgroundColor: Colors.white,
            builder: (_) {
              return BlocProvider.value(
                value: innerContext.read<GenerateNextRoundCubit>(),
                child:
                    BlocListener<
                      GenerateNextRoundCubit,
                      GenerateNextRoundState
                    >(
                      listener: (context, roundState) {
                        if (roundState is GenerateNextRoundLoadingState) {
                          Center(child: CircularProgressIndicator());
                        }
                        if (roundState is GenerateNextRoundSuccessState) {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                          TopSnackBar.show(
                            context,
                            title: 'Success',
                            message: 'The round is started successfully!',
                            contentType: ContentType.success,
                            color: ColorManager.primaryColor,
                          );
                        }
                        if (roundState is GenerateNextRoundFailureState) {
                          Navigator.pop(context);
                          TopSnackBar.show(
                            context,
                            title: 'Error',
                            message:
                                'An error occurred while trying to create round.',
                            contentType: ContentType.failure,
                            color: Colors.red,
                          );
                        }
                      },
                      child: GenerateNextRound(
                        tournamentId: widget.id,
                        numOfTeams: teamsNum ?? 0,
                      ),
                    ),
              );
            },
          );
        },
        text: 'Generate Next Round',
      ),
    );
  }
}
