import 'package:book_and_play/core/routing/routes.dart';
import 'package:book_and_play/core/widgets/app_button.dart';
import 'package:book_and_play/features/owner/tournament/presentation/manager/start_tournament_cubit/start_tournament_cubit.dart';
import 'package:book_and_play/features/owner/tournament/presentation/manager/start_tournament_cubit/start_tournament_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartTournamentBlocConsumer extends StatelessWidget {
  const StartTournamentBlocConsumer({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StartTournamentCubit, StartTournamentState>(
      listener: (context, state) {
        if (state is StartTournamentSuccessState) {
          Navigator.pushNamed(context, Routes.teamsScheduledView);
        }
      },
      builder: (context, state) {
        return AppButton(
          onPressed: () {
            context.read<StartTournamentCubit>().startTournament(id);
          },
          text: 'Start Tournament',
        );
      },
    );
  }
}
