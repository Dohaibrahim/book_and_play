import 'package:book_and_play/core/routing/routes.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/core/widgets/app_button.dart';
import 'package:book_and_play/features/owner/tournament/presentation/widget/tournament_card.dart';
import 'package:flutter/material.dart';

class TeamsJoinedViewBody extends StatelessWidget {
  const TeamsJoinedViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: screenHeight * 0.10),
          Text('Teams Joined', style: TextStyles.font32BlockBold),
          SizedBox(height: 15),
          TournamentCard(
            subTitle: '3 may 2025',
            title: 'The Offsiders',
            onTap: () {
              //check if not startted yet , if started => validate in which round and go to it
              //if not started => go to see teams that joined screen
              //Navigator.pushNamed(context, Routes.teamsJoinedView);
            },
          ),
          Expanded(child: SizedBox()),
          AppButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.teamsScheduledView);
            },
            text: 'Start Tournament',
          ),
          SizedBox(height: screenHeight * 0.05),
        ],
      ),
    );
  }
}
