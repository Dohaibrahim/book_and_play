import 'package:book_and_play/core/routing/routes.dart';
import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/core/widgets/tournament_status_card.dart';
import 'package:flutter/material.dart';

class LatestTournaments extends StatelessWidget {
  const LatestTournaments({super.key, required this.fetchAll});
  final bool fetchAll;
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        TournamentCard(
          name: 'Goal Masters',
          fieldName: 'at Sportage stadium',
          location: 'Cairo , Egypt',
          date: '3 May : 1 June ',
          status: 'ongoing',
        ),
        TournamentCard(
          name: 'Goal Masters',
          fieldName: 'at Sportage stadium',
          location: 'Cairo , Egypt',
          date: '3 May : 1 June ',
          status: 'upcoming',
        ),
      ],
    );
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
                Text(
                  name,
                  style: TextStyles.font24BlackBold.copyWith(fontSize: 20),
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
