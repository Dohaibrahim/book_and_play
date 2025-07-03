import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/core/widgets/top_snackbar.dart';
import 'package:book_and_play/features/owner/owner_fields/data/models/owner_fields.dart';
import 'package:book_and_play/features/owner/owner_fields/presentation/manager/delete_field_cubit/delete_field_cubit.dart';
import 'package:book_and_play/features/owner/owner_fields/presentation/manager/delete_field_cubit/delete_field_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteFieldBlocProvider extends StatelessWidget {
  const DeleteFieldBlocProvider({super.key, required this.args});

  final OwnerField args;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeleteFieldCubit(),
      child: BlocConsumer<DeleteFieldCubit, DeleteFieldState>(
        listener: (context, state) {
          if (state is DeleteFieldSuccessState) {
            Navigator.pop(context);
            Navigator.pop(context);
            TopSnackBar.show(
              context,
              title: context.tr('success_title'),
              message: context.tr('field_deleted_success'),
              contentType: ContentType.success,
              color: ColorManager.primaryColor,
            );
          }
          if (state is DeleteFieldFailureState) {
            TopSnackBar.show(
              context,
              title: context.tr('error_title'),
              message: state.errorMessage,
              contentType: ContentType.failure,
              color: Colors.red,
            );
          }
        },
        builder: (context, state) {
          return AlertDialog(
            title: SizedBox(),
            content: Text(
              context.tr('delete_field_confirmation'),
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
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  context.read<DeleteFieldCubit>().deleteField(args.id);
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
      ),
    );
  }
}
