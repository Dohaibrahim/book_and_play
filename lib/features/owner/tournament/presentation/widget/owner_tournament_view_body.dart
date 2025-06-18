import 'dart:developer';

import 'package:book_and_play/core/routing/routes.dart';
import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/features/owner/tournament/presentation/manager/fetch_tournaments/fetch_tournaments_cubit.dart';
import 'package:book_and_play/features/owner/tournament/presentation/manager/fetch_tournaments/ffetch_tournaments_state.dart';
import 'package:book_and_play/features/owner/tournament/presentation/widget/tournament_card.dart';
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
          Text('Your tournaments', style: TextStyles.font32BlockBold),
          SizedBox(height: 15),
          BlocBuilder<FetchTournamentsCubit, FetchTournamentsState>(
            builder: (context, state) {
              if (state is FetchTournamentsFailureState) {
                return Center(
                  child: Text(
                    'There are an error write now , please reach out our team',
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
                return Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: state.tournament.length,
                    itemBuilder: (context, index) {
                      return TournamentCard(
                        tournamentStatus: TournamentStatus.upcoming.name,
                        subTitle:
                            'from ${formatDateToReadable(state.tournament[index].startDate)} to ${formatDateToReadable(state.tournament[index].endDate)}',
                        title: state.tournament[index].name,
                        onTap: () {
                          switch (state.tournament[index].status) {
                            case 'upcoming':
                              Navigator.pushNamed(
                                context,
                                Routes.teamsJoinedView,
                                arguments: state.tournament[index].id,
                              );
                            case 'ongoing':
                              Navigator.pushNamed(
                                context,
                                Routes.teamsJoinedView,
                              );
                            case 'finished':
                              Navigator.pushNamed(
                                context,
                                Routes.teamsJoinedView,
                              );
                          }

                          //check if not startted yet , if started => validate in which round and go to it
                          //if not started => go to see teams that joined screen
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

  String formatDateToReadable(DateTime inputDate) {
    List<String> months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    String day = inputDate.day.toString();
    String month = months[inputDate.month - 1];
    String year = inputDate.year.toString();

    return '$day $month $year';
  }
}
