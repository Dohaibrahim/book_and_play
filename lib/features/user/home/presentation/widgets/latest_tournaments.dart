import 'package:book_and_play/core/routing/routes.dart';
import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/core/widgets/tournament_status_card.dart';
import 'package:book_and_play/features/user/tournaments/presentation/manager/fetch_tournaments/fetch_tournaments_cubit.dart';
import 'package:book_and_play/features/user/tournaments/presentation/manager/fetch_tournaments/fetch_tournaments_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class LatestTournaments extends StatelessWidget {
  const LatestTournaments({super.key, required this.fetchAll});
  final bool fetchAll;
  @override
  Widget build(BuildContext context) {
    context.read<FetchTournamentsCubit>().fetchTournaments();
    return BlocBuilder<FetchTournamentsCubit, FetchTournamentsState>(
      builder: (context, state) {
        if (state is FetchTournamentsLoadingState) {
          return Center(
            child: CircularProgressIndicator(color: ColorManager.primaryColor),
          );
        }
        if (state is FetchTournamentsSuccessState) {
          return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: fetchAll == true
                ? state.tournaments.length
                : state.tournaments.take(5).length,
            itemBuilder: (context, index) {
              return TournamentCard(
                name: state.tournaments[index].name,
                fieldName: state.tournaments[index].name,
                location: 'Cairo , Egypt',
                date:
                    '${formatDate(state.tournaments[index].startDate)} - ${formatDate(state.tournaments[index].endDate)}',
                status: 'ongoing',
              );
            },
          );
        }
        return SizedBox();
      },
    );
  }

  String formatDate(DateTime date) {
    return DateFormat('d MMMM').format(date);
  }
}

class TournamentCard extends StatelessWidget {
  const TournamentCard({
    super.key,
    required this.name,
    required this.fieldName,
    required this.location,
    required this.date,
    required this.status,
  });
  final String name, fieldName, location, date, status;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.tournamentDetailsView,
          arguments: {},
        );
      },
      child: Container(
        height: 160,
        margin: EdgeInsets.only(bottom: 15),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[400]!),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: screenWidth * 0.50,
                  child: Text(
                    name,
                    style: TextStyles.font24BlackBold.copyWith(fontSize: 18),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                Text(fieldName, style: TextStyle(color: Colors.grey[700])),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/icons/maps_marker_icon.png',
                      width: 20,
                      height: 25,
                    ),
                    Text(
                      location,
                      style: TextStyles.font14BlackMedium.copyWith(
                        color: ColorManager.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                Text('Knockout'),
              ],
            ),
            Column(
              children: [
                SizedBox(height: 20),
                Text(
                  date,
                  style: TextStyles.font14BlackMedium.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 10),
                TournamentStatusCard(tournamentStatus: status),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
