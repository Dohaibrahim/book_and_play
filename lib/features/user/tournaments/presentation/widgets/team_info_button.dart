import 'dart:developer';
import 'package:book_and_play/core/routing/routes.dart';
import 'package:book_and_play/core/utils/constant.dart';
import 'package:book_and_play/core/utils/shared_pref.dart';
import 'package:book_and_play/core/widgets/app_button.dart';
import 'package:book_and_play/features/user/tournaments/data/models/tournament_details_res.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TeamInfoButton extends StatelessWidget {
  const TeamInfoButton({super.key, required this.teams});
  final List<Team> teams;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getUserId(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox();
        }
        if (!snapshot.hasData) {
          return const Text('Failed to load user ID');
        }
        final userId = snapshot.data!;
        Team? teamUserIn;
        final isUserInTeam = teams.any((team) {
          if (team.members.contains(userId)) {
            teamUserIn = team;
            return true;
          }
          return false;
        });
        return isUserInTeam
            ? AppButton(
                onPressed: () {
                  log(teamUserIn!.name);
                  Navigator.pushNamed(
                    context,
                    Routes.playersOfTeamView,
                    arguments: {
                      'id': teamUserIn!.id,
                      'teamName': teamUserIn!.name,
                    },
                  );
                },
                text: 'team_info.see_your_team'.tr(),
                buttonColor: Colors.grey[400],
                textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              )
            : const SizedBox();
      },
    );
  }

  Future<String> getUserId() async {
    return await SharedPrefHelper.getString(SharedPrefKeys.userid);
  }
}
