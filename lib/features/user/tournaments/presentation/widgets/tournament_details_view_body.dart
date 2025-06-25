import 'package:book_and_play/core/routing/routes.dart';
import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/core/widgets/app_button.dart';
import 'package:book_and_play/core/widgets/tournament_status_card.dart';
import 'package:book_and_play/features/owner/tournament/presentation/widget/teams_card.dart';
import 'package:flutter/material.dart';

class TournamentDetailsViewBody extends StatelessWidget {
  const TournamentDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: screenHeight * 0.12),
          Text(
            'Goal Masters',
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
              TournamentStatusCard(tournamentStatus: 'ongoing'),
            ],
          ),
          SizedBox(height: 10),
          Text('From 3 May ', style: TextStyle(fontSize: 18)),
          Text('To 1 June ', style: TextStyle(fontSize: 18)),
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
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                TeamCard(subTitle: 'The Offsiders', title: '3 may 2025'),
                TeamCard(subTitle: 'The Offsiders', title: '3 may 2025'),
                TeamCard(subTitle: 'The Offsiders', title: '3 may 2025'),
                TeamCard(subTitle: 'The Offsiders', title: '3 may 2025'),
              ],
            ),
          ),
          SizedBox(height: 20),
          AppButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.registerTeamView);
            },
            text: 'Join',
            textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
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
      ),
    );
  }
}
