import 'package:book_and_play/features/user/home/presentation/widgets/latest_tournaments.dart';
import 'package:flutter/material.dart';

class TournamentsViewBody extends StatelessWidget {
  const TournamentsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 15),
      child: const LatestTournaments(fetchAll: true),
    );
  }
}
