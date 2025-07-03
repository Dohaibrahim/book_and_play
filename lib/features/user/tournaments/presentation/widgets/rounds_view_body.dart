import 'package:book_and_play/core/routing/routes.dart';
import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/features/owner/tournament/data/models/teams_matches_res.dart';
import 'package:book_and_play/features/owner/tournament/presentation/manager/get_matches/get_matches_cubit.dart';
import 'package:book_and_play/features/owner/tournament/presentation/manager/get_matches/get_matches_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoundsViewBody extends StatelessWidget {
  const RoundsViewBody({super.key, required this.tournamentId});
  final String tournamentId;
  @override
  Widget build(BuildContext context) {
    context.read<GetMatchesCubit>().getMatches(tournamentId);
    return BlocBuilder<GetMatchesCubit, GetMatchesState>(
      builder: (context, state) {
        var round;
        if (state is GetMatchesSuccessState) {
          if (state.rounds.roundOf16.isEmpty) {
            if (state.rounds.quarterfinal.isEmpty) {
              round = 'round_stage.quarter_final'
                  .tr(); //'at quarter final stage';
            } else if (state.rounds.semifinal.isEmpty) {
              round = 'round_stage.semi_final'.tr();
            } else if (state.rounds.finalRound.isEmpty) {
              round = 'round_stage.final'.tr();
            } else {
              round = 'round_stage.finished'.tr();
            }
          }
          return Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: 90),
                Text('${round}', style: TextStyles.font24BlackBold),
                BracketTreeView(rounds: state.rounds),
                //AppButton(onPressed: () {}, text: 'text'),
              ],
            ),
          );
        }
        return SizedBox();
      },
    );
  }
}

class BracketLinePainter extends CustomPainter {
  final Rounds rounds;

  BracketLinePainter({required this.rounds});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 2;

    double columnSpacing = 250;
    double rowSpacing = 60;

    int roundIndex = 0;

    void drawConnections({required int roundIndex, required int toMatchCount}) {
      for (int i = 0; i < toMatchCount; i++) {
        int fromIndex1 = i * 2;
        int fromIndex2 = i * 2 + 1;

        double fromLeft = roundIndex * columnSpacing;
        double toLeft = (roundIndex + 1) * columnSpacing;

        double fromTop1 =
            ((rowSpacing * (1 << roundIndex)) / 2) +
            fromIndex1 * rowSpacing * (1 << (roundIndex + 1));
        double fromTop2 =
            ((rowSpacing * (1 << roundIndex)) / 2) +
            fromIndex2 * rowSpacing * (1 << (roundIndex + 1));
        double toTop =
            ((rowSpacing * (1 << (roundIndex + 1))) / 2) +
            i * rowSpacing * (1 << (roundIndex + 2));

        Offset p1 = Offset(
          fromLeft + 140,
          fromTop1 + 40,
        ); // right center of card 1
        Offset p2 = Offset(
          fromLeft + 140,
          fromTop2 + 40,
        ); // right center of card 2
        Offset pMid = Offset(
          toLeft,
          toTop + 40,
        ); // left center of destination card
        Offset midH1 = Offset((p1.dx + pMid.dx) / 2, p1.dy);
        Offset midH2 = Offset((p2.dx + pMid.dx) / 2, p2.dy);
        // draw horizontal from left match 1
        canvas.drawLine(p1, midH1, paint);
        // draw horizontal from left match 2
        canvas.drawLine(p2, midH2, paint);
        // vertical line between both
        canvas.drawLine(midH1, midH2, paint);
        // line from center to destination match
        canvas.drawLine(Offset(midH1.dx, toTop + 40), pMid, paint);
      }
    }

    // Round of 16 connections (only if exists)
    if (rounds.roundOf16.isNotEmpty) {
      drawConnections(roundIndex: roundIndex, toMatchCount: 4);
      roundIndex++;
    }

    // Quarterfinal → Semifinal
    drawConnections(roundIndex: roundIndex, toMatchCount: 2);
    roundIndex++;

    // Semifinal → Final
    drawConnections(roundIndex: roundIndex, toMatchCount: 1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class BracketTreeView extends StatelessWidget {
  final Rounds rounds;

  const BracketTreeView({super.key, required this.rounds});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    double columnSpacing = 250;
    double totalWidth = (rounds.roundOf16.isNotEmpty ? 4 : 3) * columnSpacing;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        height: screenHeight * 0.60,
        width: totalWidth,
        child: Stack(
          children: [
            // Bracket lines
            CustomPaint(
              size: Size(totalWidth, 1000),
              painter: BracketLinePainter(rounds: rounds),
            ),
            // Match cards (positioned)
            ..._buildMatchCards(rounds),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildMatchCards(Rounds rounds) {
    List<Widget> cards = [];

    double columnSpacing = 250;
    double rowSpacing = 60;
    int currentIndex = 0;

    void addRound(
      List<MatchScheduled> matches,
      int roundIndex,
      int expectedCount,
    ) {
      double baseTop = (rowSpacing * (1 << roundIndex)) / 2;

      for (int i = 0; i < expectedCount; i++) {
        double left = roundIndex * columnSpacing;
        double top = baseTop + i * rowSpacing * (1 << (roundIndex + 1));
        MatchScheduled? match = i < matches.length ? matches[i] : null;
        cards.add(PositionedMatchCard(match: match, left: left, top: top));
      }
    }

    // Handle round of 16 only if not empty
    if (rounds.roundOf16.isNotEmpty) {
      addRound(rounds.roundOf16, currentIndex, 8);
      currentIndex++;
    }

    // Quarterfinal (4 matches)
    addRound(rounds.quarterfinal, currentIndex, 4);
    currentIndex++;

    // Semifinal (2 matches)
    addRound(rounds.semifinal, currentIndex, 2);
    currentIndex++;

    // Final (1 match)
    addRound(rounds.finalRound, currentIndex, 1);

    return cards;
  }
}

class PositionedMatchCard extends StatelessWidget {
  final MatchScheduled? match;
  final double left;
  final double top;

  const PositionedMatchCard({
    super.key,
    required this.match,
    required this.left,
    required this.top,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      top: top,
      child: Container(
        width: 140,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: ColorManager.primaryColor),
          borderRadius: BorderRadius.circular(12),
        ),
        child: match == null
            ? SizedBox(height: 50)
            : GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    Routes.matchDetailesView,
                    arguments: match,
                  );
                },
                child: Column(
                  children: [
                    Text(
                      match!.teamA.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('match.vs'.tr()),
                    Text(
                      match!.teamB.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
