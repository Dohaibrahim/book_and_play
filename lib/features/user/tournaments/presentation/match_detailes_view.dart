import 'package:book_and_play/features/owner/tournament/data/models/teams_matches_res.dart';
import 'package:book_and_play/features/user/booking/presentation/manager/fetch_field_by_id/fetch_field_by_id_cubit.dart';
import 'package:book_and_play/features/user/tournaments/presentation/widgets/match_details_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MatchDetailesView extends StatelessWidget {
  const MatchDetailesView({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as MatchScheduled;
    return BlocProvider(
      create: (context) => FetchFieldByIdCubit(fieldId: args.fieldId),
      child: Scaffold(body: MatchDetailsViewBody(match: args)),
    );
  }
}
