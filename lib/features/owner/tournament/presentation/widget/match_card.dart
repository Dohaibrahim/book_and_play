import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:flutter/material.dart';

class MatchCard extends StatelessWidget {
  const MatchCard({
    super.key,
    required this.teamsAName,
    required this.date,
    required this.time,
    required this.score,
    required this.teamsBName,
  });
  final String teamsAName, date, time, score, teamsBName;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      height: 170,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.transparent),
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/match_card1.png'),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.10),
            offset: Offset(0, 5),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            teamsAName,

            style: TextStyles.font24BlackBold.copyWith(color: Colors.white),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                date,
                //formatToReadableDate(
                //  currentMatches[index].date.toString(),
                //),
                style: TextStyles.font14BlackMedium.copyWith(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              Text(
                time,

                style: TextStyles.font14BlackMedium.copyWith(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 1),
              Text(
                score,
                style: TextStyles.font14BlackMedium.copyWith(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
          Text(
            teamsBName,

            style: TextStyles.font24BlackBold.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
