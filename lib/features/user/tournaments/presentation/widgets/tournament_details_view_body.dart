import 'package:book_and_play/core/routing/routes.dart';
import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/core/widgets/app_button.dart';
import 'package:book_and_play/core/widgets/tournament_status_card.dart';
import 'package:book_and_play/features/owner/tournament/presentation/widget/teams_card.dart';
import 'package:book_and_play/features/user/booking/presentation/football_field_view.dart';
import 'package:book_and_play/features/user/tournaments/data/models/get_tournaments_res.dart';
import 'package:book_and_play/features/user/tournaments/presentation/manager/get_specific_tournament/get_specific_tournament_cubit.dart';
import 'package:book_and_play/features/user/tournaments/presentation/manager/get_specific_tournament/get_specific_tournament_state.dart';
import 'package:book_and_play/features/user/tournaments/presentation/widgets/team_info_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TournamentDetailsViewBody extends StatelessWidget {
  const TournamentDetailsViewBody({
    super.key,
    required this.id,
    required this.fields,
  });
  final String id;
  final List<Field> fields;
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
                '${'tournament.error'.tr()} : ${state.msg}',
                //'error : ${state.msg}',
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
                    fields.length > 1
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'tournament.fields'.tr(),
                                style: TextStyles.font24BlackBold.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                ),
                              ),
                              ...fields.map((field) {
                                return TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => FootballFieldView(
                                          fieldId: field.id,
                                        ),
                                      ),
                                    );
                                  },
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    minimumSize: Size(0, 0),
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  child: Text(
                                    field.name,
                                    style: TextStyles.font24BlackBold.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: ColorManager.primaryColor,
                                      fontSize: 18,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ],
                          )
                        : Text(
                            fields[0].name,
                            style: TextStyles.font24BlackBold.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 23,
                            ),
                          ),
                    fields.length > 1
                        ? SizedBox()
                        : TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      FootballFieldView(fieldId: fields[0].id),
                                ),
                              );
                            },
                            child: Text(
                              'tournament.get_info'.tr(),
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
                    Expanded(child: SizedBox()),
                    TournamentStatusCard(
                      tournamentStatus: state.tournament.status,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  state.tournament.description,
                  style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                ),
                SizedBox(height: 10),
                state.tournament.isPrivate
                    ? Text(
                        '${'tournament.private_for'.tr()} ${state.tournament.institution} ${'tournament.only'.tr()}',
                        //'For ${state.tournament.institution} only',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    : SizedBox(),
                Text(
                  '${'tournament.from'.tr()} ${formatDate(state.tournament.startDate)}',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  '${'tournament.to'.tr()} ${formatDate(state.tournament.endDate)}',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 10),
                Text(
                  '${'tournament.type'.tr()} : Knockout',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 30),
                Text(
                  'tournament.teams_joined'.tr(),
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 10),
                state.tournament.teams.isEmpty
                    ? Expanded(
                        child: Center(child: Text('tournament.be_first'.tr())),
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
                state.tournament.status == 'ongoing'
                    ? AppButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            Routes.roundsView,
                            arguments: state.tournament.id,
                          );
                        },
                        text: 'tournament.view_matches_rounds'.tr(),
                        textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    : SizedBox(),
                state.tournament.status == 'finished'
                    ? AppButton(
                        onPressed: () {},
                        text: 'tournament.view_winner'.tr(),
                        textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    : SizedBox(),
                state.tournament.status != 'upcoming' ||
                        state.tournament.maxTeams ==
                            state.tournament.teams.length
                    ? SizedBox()
                    : AppButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            Routes.registerTeamView,
                            arguments: id,
                          );
                        },
                        text: 'tournament.join'.tr(),
                        textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                SizedBox(height: 10),
                state.tournament.status == 'upcoming'
                    ? TeamInfoButton(teams: state.tournament.teams)
                    : SizedBox(),
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
