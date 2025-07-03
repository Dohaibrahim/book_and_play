import 'dart:developer';

import 'package:book_and_play/core/routing/routes.dart';
import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/features/owner/tournament/presentation/manager/fetch_tournaments/fetch_tournaments_cubit.dart';
import 'package:book_and_play/features/owner/tournament/presentation/manager/fetch_tournaments/ffetch_tournaments_state.dart';
import 'package:book_and_play/features/owner/tournament/presentation/widget/tournament_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OwnerTournamentViewBody extends StatelessWidget {
  const OwnerTournamentViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<FetchTournamentsCubit>().fetchAlltournaments();
    final screenHeight = MediaQuery.sizeOf(context).height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: screenHeight * 0.10),
          Text(
            'owner_tournament.title'.tr(),
            style: TextStyles.font32BlockBold,
          ),
          SizedBox(height: 15),
          BlocBuilder<FetchTournamentsCubit, FetchTournamentsState>(
            builder: (context, state) {
              if (state is FetchTournamentsFailureState) {
                return Center(
                  child: Text(
                    'owner_tournament.error_message'.tr(),
                    style: TextStyles.font24BlackBold,
                  ),
                );
              }
              if (state is FetchTournamentsLoadingState) {
                return Expanded(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: ColorManager.primaryColor,
                    ),
                  ),
                );
              }
              if (state is FetchTournamentsSuccessState) {
                if (state.tournament.isEmpty) {
                  return Expanded(
                    child: Center(
                      child: Text('owner_tournament.empty_message'.tr()),
                    ),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: state.tournament.length,
                    itemBuilder: (context, index) {
                      return TournamentCard(
                        tournamentStatus: state
                            .tournament[index]
                            .status, //TournamentStatus.upcoming.name,
                        subTitle:
                            '${'owner_tournament.from'.tr()} ${formatDateToReadable(state.tournament[index].startDate, context)} ${'owner_tournament.to'.tr()} ${formatDateToReadable(state.tournament[index].endDate, context)}',
                        title: state.tournament[index].name,
                        onTap: () {
                          switch (state.tournament[index].status) {
                            case 'upcoming':
                              Navigator.pushNamed(
                                context,
                                Routes.teamsJoinedView,
                                arguments: {
                                  'id': state.tournament[index].id,
                                  'teamsNum': state.tournament[index].maxTeams,
                                },
                              );
                            case 'ongoing':
                              Navigator.pushNamed(
                                context,
                                Routes.teamsScheduledView,
                                arguments: state.tournament[index].id,
                              );
                            case 'finished':
                              Navigator.pushNamed(
                                context,
                                Routes.finalResultView,
                                arguments: state.tournament[index].id,
                              );
                          }
                        },
                      );
                    },
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

  String formatDateToReadable(DateTime inputDate, BuildContext context) {
    List<String> months = [
      context.tr('month.january'),
      context.tr('month.february'),
      context.tr('month.march'),
      context.tr('month.april'),
      context.tr('month.may'),
      context.tr('month.june'),
      context.tr('month.july'),
      context.tr('month.august'),
      context.tr('month.september'),
      context.tr('month.october'),
      context.tr('month.november'),
      context.tr('month.december'),
    ];

    String day = inputDate.day.toString();
    String month = months[inputDate.month - 1];
    String year = inputDate.year.toString();

    return '$day $month $year';
  }
}
