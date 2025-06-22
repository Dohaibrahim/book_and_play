import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:flutter/material.dart';

class TeamCard extends StatelessWidget {
  const TeamCard({super.key, required this.subTitle, required this.title});

  final String title, subTitle;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: 100,
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
          Text(subTitle, style: TextStyles.font14BlackMedium),
        ],
      ),
    );
  }
}

enum TournamentStatus { upcoming, onGoing, finished }
