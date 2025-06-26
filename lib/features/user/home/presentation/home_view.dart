import 'package:book_and_play/features/user/home/presentation/widgets/home_view_body.dart';
import 'package:book_and_play/features/user/tournaments/presentation/manager/fetch_tournaments/fetch_tournaments_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchTournamentsCubit(),
      child: Scaffold(
        //backgroundColor: Colors.white,
        body: HomeViewBody(),
      ),
    );
  }
}
