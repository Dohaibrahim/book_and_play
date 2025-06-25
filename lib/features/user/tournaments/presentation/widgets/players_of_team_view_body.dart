import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/core/widgets/app_button.dart';
import 'package:book_and_play/features/owner/tournament/presentation/widget/teams_card.dart';
import 'package:flutter/material.dart';

class PlayersOfTeamViewBody extends StatelessWidget {
  const PlayersOfTeamViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: screenHeight * 0.10),
          Text(
            'The Offsiders',
            style: TextStyles.font24BlackBold,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Text(
            'Players',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                TeamCard(
                  subTitle: 'ID : 68310bd971fe2ebfe0aa9edf',
                  title: 'John',
                ),
                TeamCard(
                  subTitle: 'ID : 68310bd971fe2ebfe0aa9edf',
                  title: 'John',
                ),
                TeamCard(
                  subTitle: 'ID : 68310bd971fe2ebfe0aa9edf',
                  title: 'John',
                ),
                TeamCard(
                  subTitle: 'ID : 68310bd971fe2ebfe0aa9edf',
                  title: 'John',
                ),
                TeamCard(
                  subTitle: 'ID : 68310bd971fe2ebfe0aa9edf',
                  title: 'John',
                ),
                TeamCard(
                  subTitle: 'ID : 68310bd971fe2ebfe0aa9edf',
                  title: 'John',
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          AppButton(onPressed: () {}, text: 'Join the tournament'),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
