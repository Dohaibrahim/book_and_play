import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:book_and_play/core/widgets/app_button.dart';
import 'package:book_and_play/core/widgets/top_snackbar.dart';
import 'package:book_and_play/features/owner/tournament/presentation/manager/generate_next_round_cubit/generate_next_round_cubit.dart';
import 'package:book_and_play/features/owner/tournament/presentation/manager/generate_next_round_cubit/generate_next_round_state.dart';
import 'package:book_and_play/features/owner/tournament/presentation/widget/generate_next_round.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomSheetBuilder extends StatelessWidget {
  const BottomSheetBuilder({
    super.key,
    required this.teamsNum,
    required this.isTeamsEmpty,
    required this.tournamentId,
  });

  final int? teamsNum;
  final String tournamentId;
  final bool isTeamsEmpty;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (innerContext) => teamsNum == 1
          ? AppButton(
              onPressed: () {
                Navigator.pop(context);
              },
              text: context.tr('done_button'),
            )
          : AppButton(
              onPressed: () {
                showModalBottomSheet(
                  context: innerContext,
                  backgroundColor: Colors.white,
                  builder: (_) {
                    return BlocProvider.value(
                      value: innerContext.read<GenerateNextRoundCubit>(),
                      child:
                          BlocListener<
                            GenerateNextRoundCubit,
                            GenerateNextRoundState
                          >(
                            listener: (context, roundState) {
                              if (roundState is GenerateNextRoundLoadingState) {
                                Center(child: CircularProgressIndicator());
                              }
                              if (roundState is GenerateNextRoundSuccessState) {
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pop(context);
                                TopSnackBar.show(
                                  context,
                                  title: context.tr('success_title'),
                                  message: context.tr(
                                    'round_started_success_message',
                                  ),
                                  contentType: ContentType.success,
                                  color: ColorManager.primaryColor,
                                );
                              }
                              if (roundState is GenerateNextRoundFailureState) {
                                Navigator.pop(context);
                                TopSnackBar.show(
                                  context,
                                  title: context.tr('error_title'),
                                  message: context.tr(
                                    'round_started_error_message',
                                  ),
                                  contentType: ContentType.failure,
                                  color: Colors.red,
                                );
                              }
                            },
                            child: GenerateNextRound(
                              tournamentId: tournamentId,
                              numOfTeams: teamsNum ?? 0,
                            ),
                          ),
                    );
                  },
                );
              },
              text: context.tr('generate_next_round_button'),
            ),
    );
  }
}
