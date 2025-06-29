import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/core/widgets/app_button.dart';
import 'package:book_and_play/core/widgets/app_text_form_field.dart';
import 'package:book_and_play/core/widgets/top_snackbar.dart';
import 'package:book_and_play/features/user/teams/data/models/add_player_to_team_req.dart';
import 'package:book_and_play/features/user/teams/presentation/manager/add_player_cubit/add_player_cubit.dart';
import 'package:book_and_play/features/user/teams/presentation/manager/add_player_cubit/add_player_state.dart';
import 'package:book_and_play/features/user/teams/presentation/manager/get_specific_team_cubit/get_specific_team_cubit.dart';
import 'package:book_and_play/features/user/teams/presentation/widgets/members_bloc_builder.dart';
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
              hintText: 'type player ID',
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              onSaved: (data) {
                playerId = data;
              },
            ),
            SizedBox(height: 20),
            MembersBlocBuilder(),
            SizedBox(height: 20),
            BlocConsumer<AddPlayerCubit, AddPlayerState>(
              listener: (context, state) {
                if (state is AddPlayerSuccessState) {
                  TopSnackBar.show(
                    context,
                    title: 'Success',
                    message: 'The player is successfully added to your team!',
                    contentType: ContentType.success,
                    color: ColorManager.primaryColor,
                  );
                }
                if (state is AddPlayerFailureState) {
                  TopSnackBar.show(
                    context,
                    title: 'Error',
                    message: 'The player ID you entered not valid',
                    contentType: ContentType.failure,
                    color: Colors.red,
                  );
                }
              },
              builder: (context, state) {
                if (state is AddPlayerLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: ColorManager.primaryColor,
                    ),
                  );
                }
                return AppButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      context.read<AddPlayerCubit>().addPlayer(
                        AddPlayerToTeamReq(
                          teamId: widget.teamId,
                          memberId: playerId!,
                        ),
                      );
                    } else {
                      TopSnackBar.show(
                        context,
                        title: 'Warning',
                        message: 'You should enter player ID you want to add',
                        contentType: ContentType.warning,
                        color: Colors.orange,
                      );
                    }
                  },
                  text: 'Add player',
                );
              },
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
