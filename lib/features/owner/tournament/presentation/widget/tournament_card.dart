import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:flutter/material.dart';

class TournamentCard extends StatelessWidget {
  const TournamentCard({
    super.key,
    required this.onTap,
    required this.subTitle,
    required this.title,
    required this.tournamentStatus,
  });
  final void Function()? onTap;
  final String title, subTitle;
  final String tournamentStatus;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.circular(20),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.10),
              offset: Offset(0, 5),
              blurRadius: 8,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyles.font24BlackBold.copyWith(fontSize: 20),
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(subTitle, style: TextStyles.font14BlackMedium),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: tournamentStatus == TournamentStatus.notStarted.name
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

enum TournamentStatus { notStarted, onGoing, finished }
