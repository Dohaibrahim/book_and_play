import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/core/widgets/app_text_form_field.dart';
import 'package:book_and_play/features/user/teams/presentation/manager/get_specific_team_cubit/get_specific_team_cubit.dart';
import 'package:book_and_play/features/user/teams/presentation/widgets/add_player_bloc_consumer.dart';
import 'package:book_and_play/features/user/teams/presentation/widgets/members_bloc_builder.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayersOfTeamViewBody extends StatefulWidget {
  const PlayersOfTeamViewBody({
    super.key,
    required this.teamId,
    required this.teamName,
  });
  final String teamId, teamName;
  @override
  State<PlayersOfTeamViewBody> createState() => _PlayersOfTeamViewBodyState();
}

class _PlayersOfTeamViewBodyState extends State<PlayersOfTeamViewBody> {
  final TextEditingController _textController = TextEditingController();
  String? playerId;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.read<GetSpecificTeamCubit>().getTeam(widget.teamId);
    final screenHeight = MediaQuery.sizeOf(context).height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: screenHeight * 0.10),
            Text(
              widget.teamName,
              style: TextStyles.font24BlackBold,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            AppTextFormField(
              controller: _textController,
              hintText: 'players_team.type_id_hint'.tr(),
              onSaved: (data) {
                playerId = data;
              },
            ),
            SizedBox(height: 20),
            MembersBlocBuilder(),
            SizedBox(height: 20),
            AddPlayerBlocConsumer(
              widget: widget,
              formKey: formKey,
              playerId: playerId,
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
