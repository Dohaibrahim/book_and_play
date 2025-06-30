import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/features/owner/tournament/presentation/manager/get_tournaments_teams/get_tournaments_teams_cubit.dart';
import 'package:book_and_play/features/owner/tournament/presentation/manager/get_tournaments_teams/get_tournaments_teams_state.dart';
import 'package:book_and_play/features/owner/tournament/presentation/widget/bottom_sheet_builder.dart';
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
  bool isTeamsEmpty = false;
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
                return SizedBox(
                  height: screenHeight * 0.79,
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            var formattedDate = formatDate(
                              teams[index].createdAt,
                            );
                            return TeamCard(
                              subTitle: formattedDate,
                              title: teams[index].name,
                            );
                          },
                          itemCount: teams.length,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.005),
                      isTeamsEmpty == true
                          ? SizedBox()
                          : BottomSheetBuilder(
                              tournamentId: widget.id,
                              teamsNum: widget.teamsNum,
                              isTeamsEmpty: isTeamsEmpty,
                            ),
                    ],
                  ),
                );
              }
              return SizedBox();
            },
          ),
        ],
      ),
    );
  }

  String formatDate(DateTime date) {
    return DateFormat('d MMMM yyyy').format(date);
  }
}
