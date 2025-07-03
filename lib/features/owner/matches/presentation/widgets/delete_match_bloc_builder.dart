import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/core/widgets/top_snackbar.dart';
import 'package:book_and_play/features/owner/matches/presentation/manager/delete_match/delete_match_cubit.dart';
import 'package:book_and_play/features/owner/matches/presentation/manager/delete_match/delete_match_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteMatchBlocBuilder extends StatelessWidget {
  const DeleteMatchBlocBuilder({super.key, required this.matchId});
  final String matchId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeleteMatchCubit, DeleteMatchState>(
      listener: (context, state) {
        if (state is DeleteMatchFailureState) {
          TopSnackBar.show(
            context,
            title: context.tr('error_title'),
            message: state.message,
            contentType: ContentType.failure,
            color: Colors.red,
          );
        }
        if (state is DeleteMatchSuccessState) {
          Navigator.pop(context);
          Navigator.pop(context);
          TopSnackBar.show(
            context,
            title: context.tr('success_title'),
            message: state.message,
            contentType: ContentType.success,
            color: ColorManager.primaryColor,
          );
        }
      },
      builder: (context, state) {
        return AlertDialog(
          title: SizedBox(),
          content: Text(
            context.tr('delete_match_confirmation'),
            textAlign: TextAlign.center,
            style: TextStyles.font24BlackBold.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                context.tr('cancel_button'),
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                context.read<DeleteMatchCubit>().deleteMatch(matchId);
              },
              child: Text(
                context.tr('confirm_button'),
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
