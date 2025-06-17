import 'package:book_and_play/features/owner/tournament/presentation/manager/fetch_tournaments/fetch_tournaments_cubit.dart';
import 'package:book_and_play/features/owner/tournament/presentation/widget/owner_tournament_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OwnerTournamentsView extends StatelessWidget {
  const OwnerTournamentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchTournamentsCubit(),
      child: const Scaffold(body: OwnerTournamentViewBody()),
    );
  }
}
