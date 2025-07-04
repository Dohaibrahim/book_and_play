import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:book_and_play/core/widgets/app_button.dart';
import 'package:book_and_play/core/widgets/top_snackbar.dart';
import 'package:book_and_play/features/user/teams/data/models/add_player_to_team_req.dart';
import 'package:book_and_play/features/user/teams/presentation/manager/add_player_cubit/add_player_cubit.dart';
import 'package:book_and_play/features/user/teams/presentation/manager/add_player_cubit/add_player_state.dart';
import 'package:book_and_play/features/user/teams/presentation/manager/get_specific_team_cubit/get_specific_team_cubit.dart';
import 'package:book_and_play/features/user/teams/presentation/widgets/players_of_team_view_body.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPlayerBlocConsumer extends StatelessWidget {
  const AddPlayerBlocConsumer({
    super.key,
    required this.widget,
    required this.formKey,
    required this.playerId,
  });

  final PlayersOfTeamViewBody widget;
  final GlobalKey<FormState> formKey;
  final String? playerId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddPlayerCubit, AddPlayerState>(
      listener: (context, state) {
        if (state is AddPlayerSuccessState) {
          TopSnackBar.show(
            context,
            title: 'add_player.success_title'.tr(),
            message: 'add_player.success_message'.tr(),
            contentType: ContentType.success,
            color: ColorManager.primaryColor,
          );
        }
        if (state is AddPlayerFailureState) {
          TopSnackBar.show(
            context,
            title: 'add_player.error_title'.tr(),
            message: 'add_player.error_message'.tr(),
            contentType: ContentType.failure,
            color: Colors.red,
          );
        }
      },
      builder: (context, state) {
        if (state is AddPlayerLoadingState) {
          return Center(
            child: CircularProgressIndicator(color: ColorManager.primaryColor),
          );
        }
        if (state is AddPlayerSuccessState) {
          context.read<GetSpecificTeamCubit>().getTeam(widget.teamId);
        }
        return AppButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              formKey.currentState!.save();
              context.read<AddPlayerCubit>().addPlayer(
                AddPlayerToTeamReq(teamId: widget.teamId, memberId: playerId!),
              );
            } else {
              TopSnackBar.show(
                context,
                title: 'add_player.warning_title'.tr(),
                message: 'add_player.warning_message'.tr(),
                contentType: ContentType.warning,
                color: Colors.orange,
              );
            }
          },
          text: 'add_player.button_text'.tr(),
        );
      },
    );
  }
}
