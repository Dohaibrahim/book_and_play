import 'package:book_and_play/features/owner/tournament/presentation/manager/get_tournaments_teams/get_tournaments_teams_cubit.dart';
import 'package:book_and_play/features/owner/tournament/presentation/widget/teams_joined_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeamsJoinedView extends StatelessWidget {
  const TeamsJoinedView({super.key});

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String;
    return BlocProvider(
      create: (context) => GetTournamentsTeamsCubit(),
      child: Scaffold(body: TeamsJoinedViewBody(id: id)),
    );
  }
}
