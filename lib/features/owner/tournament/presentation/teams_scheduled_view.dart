import 'package:book_and_play/features/owner/tournament/presentation/manager/add_score_cubit/add_score_cubit.dart';
import 'package:book_and_play/features/owner/tournament/presentation/manager/get_matches/get_matches_cubit.dart';
import 'package:book_and_play/features/owner/tournament/presentation/widget/teams_scheduled_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeamsScheduledView extends StatelessWidget {
  const TeamsScheduledView({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as String;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GetMatchesCubit()),
        BlocProvider(create: (context) => AddScoreCubit()),
      ],
      child: Scaffold(body: TeamsScheduledViewBody(id: args)),
    );
  }
}
