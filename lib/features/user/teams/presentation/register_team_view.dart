import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:book_and_play/core/routing/routes.dart';
import 'package:book_and_play/core/widgets/top_snackbar.dart';
import 'package:book_and_play/features/user/teams/presentation/manager/player_team_cubit/player_team_cubit.dart';
import 'package:book_and_play/features/user/teams/presentation/manager/player_team_cubit/player_team_state.dart';
import 'package:book_and_play/features/user/teams/presentation/widgets/register_team_view_body.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterTeamView extends StatelessWidget {
  const RegisterTeamView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlayerTeamCubit(),
      child: Scaffold(
        body: BlocListener<PlayerTeamCubit, PlayerTeamState>(
          listener: (context, state) {
            if (state is PlayerTeamSuccessState) {
              Navigator.pushReplacementNamed(
                context,
                Routes.playersOfTeamView,
                arguments: {'id': state.team.id, 'teamName': state.team.name},
              );
            }
            if (state is PlayerTeamFailureState) {
              TopSnackBar.show(
                context,
                title: 'register_team.error_title'.tr(),
                message: 'register_team.error_message'.tr(),
                contentType: ContentType.failure,
                color: Colors.red,
              );
            }
          },
          child: const RegisterTeamViewBody(),
        ),
      ),
    );
  }
}
