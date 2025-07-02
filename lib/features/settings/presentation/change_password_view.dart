import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:book_and_play/core/widgets/top_snackbar.dart';
import 'package:book_and_play/features/settings/presentation/manager/change_pass_cubit/change_pass_cubit.dart';
import 'package:book_and_play/features/settings/presentation/manager/change_pass_cubit/change_pass_state.dart';
import 'package:book_and_play/features/settings/presentation/widgets/change_password_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as String;
    return BlocProvider(
      create: (context) => ChangePassCubit(),
      child: Scaffold(
        body: BlocListener<ChangePassCubit, ChangePassState>(
          listener: (context, state) {
            if (state is ChangePassSuccessState) {
              Navigator.pop(context);
              TopSnackBar.show(
                context,
                title: 'Success',
                message: state.message,
                contentType: ContentType.success,
                color: ColorManager.primaryColor,
              );
            }
            if (state is ChangePassFailureState) {
              TopSnackBar.show(
                context,
                title: 'Error',
                message: state.errorMessage,
                contentType: ContentType.failure,
                color: Colors.red,
              );
            }
          },
          child: SafeArea(child: ChangePasswordViewBody(userEmail: args)),
        ),
      ),
    );
  }
}
