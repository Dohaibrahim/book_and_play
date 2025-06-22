import 'package:book_and_play/core/routing/routes.dart';
import 'package:book_and_play/core/widgets/app_button.dart';
import 'package:book_and_play/features/owner/tournament/presentation/manager/generate_next_round_cubit/generate_next_round_cubit.dart';
import 'package:book_and_play/features/owner/tournament/presentation/manager/generate_next_round_cubit/generate_next_round_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
/*
class StartTournamentBlocConsumer extends StatelessWidget {
  const StartTournamentBlocConsumer({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GenerateNextRoundCubit, GenerateNextRoundState>(
      listener: (context, state) {
        if (state is GenerateNextRoundSuccessState) {
          Navigator.pushNamed(context, Routes.teamsScheduledView);
        }
      },
      builder: (context, state) {
        return AppButton(
          onPressed: () {
            //context.read<GenerateNextRoundCubit>().generateRound(id , );
          },
          text: 'owner_tournament.start'.tr(),
        );
      },
    );
  }
}
*/