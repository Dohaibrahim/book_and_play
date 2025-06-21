import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/features/owner/tournament/presentation/manager/get_tournaments_teams/get_tournaments_teams_cubit.dart';
import 'package:book_and_play/features/owner/tournament/presentation/manager/get_tournaments_teams/get_tournaments_teams_state.dart';
import 'package:book_and_play/features/owner/tournament/presentation/widget/start_tournament_bloc_consumer.dart';
import 'package:book_and_play/features/owner/tournament/presentation/widget/teams_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TeamsJoinedViewBody extends StatelessWidget {
  const TeamsJoinedViewBody({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context) {
    context.read<GetTournamentsTeamsCubit>().getTeams(id);
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
                return Center(child: Text('teams_joined.error'.tr()));
              }
              if (state is GetTournamentsTeamsSuccessState) {
                var teams = state.teams;

                return Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      var formattedDate = formatDate(teams[index].createdAt);
                      return TeamCard(
                        subTitle: formattedDate,
                        title: teams[index].name,
                        onTap: () {
                          //check if not startted yet , if started => validate in which round and go to it
                          //if not started => go to see teams that joined screen
                          //Navigator.pushNamed(context, Routes.teamsJoinedView);
                        },
                      );
                    },
                    itemCount: teams.length,
                  ),
                );
              }
              return SizedBox();
            },
          ),
          StartTournamentBlocConsumer(id: id),
          SizedBox(height: screenHeight * 0.05),
        ],
      ),
    );
  }

  String formatDate(DateTime date) {
    return DateFormat('d MMMM yyyy').format(date);
  }
}
