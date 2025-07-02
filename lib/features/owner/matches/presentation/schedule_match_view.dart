import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:book_and_play/core/widgets/top_snackbar.dart';
import 'package:book_and_play/features/owner/matches/presentation/manager/create_match/create_match_cubit.dart';
import 'package:book_and_play/features/owner/matches/presentation/manager/create_match/create_match_state.dart';
import 'package:book_and_play/features/owner/owner_fields/data/models/owner_fields.dart';
import 'package:book_and_play/features/owner/matches/presentation/widgets/schedule_match_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScheduleMatchView extends StatelessWidget {
  const ScheduleMatchView({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as OwnerField;
    return BlocProvider(
      create: (context) => CreateMatchCubit(),
      child: Scaffold(
        body: BlocListener<CreateMatchCubit, CreateMatchState>(
          listener: (context, state) {
            if (state is CreateMatchSuccessState) {
              Navigator.pop(context);
              TopSnackBar.show(
                context,
                title: 'Success',
                message: state.message,
                contentType: ContentType.success,
                color: ColorManager.primaryColor,
              );
            }
            if (state is CreateMatchFailureState) {
              TopSnackBar.show(
                context,
                title: 'Error',
                message: state.errorMessage,
                contentType: ContentType.failure,
                color: Colors.red,
              );
            }
          },
          child: ScheduleMatchViewBody(ownerField: args),
        ),
      ),
    );
  }
}
