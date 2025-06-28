import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/features/owner/tournament/presentation/widget/teams_card.dart';
import 'package:book_and_play/features/user/teams/presentation/manager/get_specific_team_cubit/get_specific_team_cubit.dart';
import 'package:book_and_play/features/user/teams/presentation/manager/get_specific_team_cubit/get_specific_team_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MembersBlocBuilder extends StatelessWidget {
  const MembersBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetSpecificTeamCubit, GetSpecificTeamState>(
      builder: (context, state) {
        if (state is GetSpecificTeamLoadingState) {
          return Expanded(
            child: Center(
              child: CircularProgressIndicator(
                color: ColorManager.primaryColor,
              ),
            ),
          );
        }
        if (state is GetSpecificTeamFailureState) {
          return Expanded(
            child: Center(
              child: Text(
                'error : ${state.errorMessage}',
                style: TextStyles.font14BlackMedium,
              ),
            ),
          );
        }
        if (state is GetSpecificTeamSuccessState) {
          return Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: state.team.members.length,
              itemBuilder: (context, index) {
                return TeamCard(
                  subTitle: 'ID : ${state.team.members[index].id}',
                  title: state.team.members[index].name,
                );
              },
            ),
          );
        }
        return SizedBox();
      },
    );
  }
}
