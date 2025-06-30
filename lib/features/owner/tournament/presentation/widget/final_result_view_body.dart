import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/features/owner/tournament/presentation/manager/get_matches/get_matches_cubit.dart';
import 'package:book_and_play/features/owner/tournament/presentation/manager/get_matches/get_matches_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FinalResultViewBody extends StatelessWidget {
  const FinalResultViewBody({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context) {
    context.read<GetMatchesCubit>().getMatches(id);
    final screenHeight = MediaQuery.sizeOf(context).height;
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 15),
      child: BlocBuilder<GetMatchesCubit, GetMatchesState>(
        builder: (context, state) {
          if (state is GetMatchesSuccessState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: screenHeight * 0.15),
                Text(
                  'Result',
                  style: TextStyles.font24BlackBold.copyWith(fontSize: 28),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Container(
                  height: screenHeight * 0.30,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[400]!),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            state.rounds.finalRound[0].teamA.name,
                            style: TextStyles.font24BlackBold.copyWith(
                              fontSize: 20,
                            ),
                          ),
                          Image.asset(
                            'assets/gifs/winning_gif.gif',
                            width: 100,
                            height: 100,
                          ),
                          Text(
                            state.rounds.finalRound[0].teamB.name,
                            style: TextStyles.font24BlackBold.copyWith(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '${state.rounds.finalRound[0].score.teamA} - ${state.rounds.finalRound[0].score.teamB}',
                        textAlign: TextAlign.center,
                        style: TextStyles.font24BlackBold.copyWith(
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          if (state is GetMatchesLoadingState) {
            return Center(
              child: CircularProgressIndicator(
                color: ColorManager.primaryColor,
              ),
            );
          }
          if (state is GetMatchesFailureState) {
            return Center(child: Text('error : ${state.errorMsg}'));
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
