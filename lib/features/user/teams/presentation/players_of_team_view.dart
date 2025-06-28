import 'package:book_and_play/features/user/teams/presentation/manager/get_specific_team_cubit/get_specific_team_cubit.dart';
import 'package:book_and_play/features/user/teams/presentation/widgets/players_of_team_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayersOfTeamView extends StatelessWidget {
  const PlayersOfTeamView({super.key});
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return BlocProvider(
      create: (context) => GetSpecificTeamCubit(),
      child: Scaffold(
        body: PlayersOfTeamViewBody(
          teamId: args['id'],
          teamName: args['teamName'],
        ),
      ),
    );
  }
}
