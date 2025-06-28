import 'package:book_and_play/features/user/tournaments/presentation/manager/get_specific_tournament/get_specific_tournament_cubit.dart';
import 'package:book_and_play/features/user/tournaments/presentation/widgets/tournament_details_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TournamentDetailsView extends StatelessWidget {
  const TournamentDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return BlocProvider(
      create: (context) => GetSpecificTournamentCubit(),

      child: Scaffold(
        body: TournamentDetailsViewBody(id: args['id'], fields: args['fields']),
      ),
    );
  }
}
