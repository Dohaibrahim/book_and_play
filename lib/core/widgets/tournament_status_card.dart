import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/features/owner/tournament/presentation/widget/tournament_card.dart';
import 'package:flutter/material.dart';

class TournamentStatusCard extends StatelessWidget {
  const TournamentStatusCard({super.key, required this.tournamentStatus});

  final String tournamentStatus;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: tournamentStatus == TournamentStatus.upcoming.name
            ? Color(0xffFAA60A)
            : tournamentStatus == TournamentStatus.finished.name
            ? Color(0xffFB120A)
            : Color(0xff23CF5F),
        border: Border.all(color: Colors.transparent),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        tournamentStatus,
        style: TextStyles.font14BlackMedium.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
