import 'dart:developer';
import 'package:book_and_play/features/owner/tournament/data/models/generate_next_round_req.dart';
import 'package:book_and_play/features/owner/tournament/presentation/manager/generate_next_round_cubit/generate_next_round_cubit.dart';
import 'package:book_and_play/features/owner/tournament/presentation/manager/generate_next_round_cubit/generate_next_round_state.dart';
import 'package:book_and_play/features/owner/tournament/presentation/widget/schedule_date.dart';
import 'package:book_and_play/features/owner/tournament/presentation/widget/show_hour_range.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GenerateNextRound extends StatelessWidget {
  const GenerateNextRound({
    super.key,
    required this.numOfTeams,
    required this.tournamentId,
  });
  final int numOfTeams;
  final String tournamentId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GenerateNextRoundCubit, GenerateNextRoundState>(
      builder: (context, generateNextRoundState) {
        return ScheduleDate(
          numOfTeams: numOfTeams,
          onSubmit: (List<MatchTimeEntity> times) {
            List<TimeReq> timesReq = [];
            for (var time in times) {
              timesReq.add(
                TimeReq(
                  start: time.formatTimeOfDay24(time.from),
                  end: time.formatTimeOfDay24(time.to),
                ),
              );
              log(
                "From: ${time.from.format(context)}, To: ${time.to.format(context)}",
              );
            }
            context.read<GenerateNextRoundCubit>().generateRound(
              tournamentId,
              NextRoundReq(times: timesReq),
            );
          },
        );
      },
    );
  }
}
