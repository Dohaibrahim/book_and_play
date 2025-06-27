import 'package:book_and_play/core/routing/routes.dart';
import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/core/widgets/app_button.dart';
import 'package:book_and_play/core/widgets/tournament_status_card.dart';
import 'package:book_and_play/features/owner/tournament/presentation/widget/teams_card.dart';
import 'package:book_and_play/features/user/tournaments/presentation/manager/get_specific_tournament/get_specific_tournament_cubit.dart';
import 'package:book_and_play/features/user/tournaments/presentation/manager/get_specific_tournament/get_specific_tournament_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TournamentDetailsViewBody extends StatelessWidget {
  const TournamentDetailsViewBody({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context) {
    context.read<GetSpecificTournamentCubit>().getTournament(id);
    final screenHeight = MediaQuery.sizeOf(context).height;
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
      child: BlocBuilder<GetSpecificTournamentCubit, GetSpecificTournamentState>(
        builder: (context, state) {
          if (state is GetSpecificTournamentLoadingState) {
            return Center(
              child: CircularProgressIndicator(
                color: ColorManager.primaryColor,
              ),
            );
          }
          if (state is GetSpecificTournamentFailureState) {
            return Center(
              child: Text(
                'error : ${state.msg}',
                style: TextStyles.font14BlackMedium,
              ),
            );
          }
          if (state is GetSpecificTournamentSuccessState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: screenHeight * 0.12),
                Text(
                  state.tournament.name,
                  style: TextStyles.font24BlackBold,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'at Sportage stadium',
                      style: TextStyles.font24BlackBold.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 23,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'get info',
                        style: TextStyle(
                          color: ColorManager.primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/icons/maps_marker_icon.png',
                      width: 30,
                      height: 30,
                    ),
                    Text(
                      'Cairo , Egypt',
                      style: TextStyles.font14BlackMedium.copyWith(
                        color: ColorManager.primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    TournamentStatusCard(
                      tournamentStatus: state.tournament.status,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  state.tournament.description,
                  style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                ),
                Text(
                  'From ${formatDate(state.tournament.startDate)}',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'To ${formatDate(state.tournament.endDate)}',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 10),
                Text(
                  'Type : Knockout',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 30),
                Text(
                  'Teams Joined',
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 10),
                state.tournament.teams.isEmpty
                    ? Expanded(
                        child: Center(
                          child: Text('There are no Teams Joined till now'),
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: state.tournament.teams.length,
                          itemBuilder: (context, index) {
                            return TeamCard(
                              subTitle:
                                  'ID : ${state.tournament.teams[index].id}',
                              title: state.tournament.teams[index].name,
                            );
                          },
                          padding: EdgeInsets.zero,
                        ),
                      ),
                SizedBox(height: 20),
                state.tournament.status != 'upcoming' ||
                        state.tournament.maxTeams ==
                            state.tournament.teams.length
                    ? SizedBox()
                    : AppButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.registerTeamView);
                        },
                        text: 'Join',
                        textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                SizedBox(height: 10),
                AppButton(
                  onPressed: () {},
                  text: 'Football field details',
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  buttonColor: Color(0xffF4FAF4),
                ),
                SizedBox(height: 30),
              ],
            );
          }
          return SizedBox();
        },
      ),
    );
  }

  String formatDate(DateTime date) {
    return DateFormat('d MMMM').format(date);
  }
}
