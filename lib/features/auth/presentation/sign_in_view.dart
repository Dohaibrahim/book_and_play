import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:book_and_play/core/routing/routes.dart';
import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:book_and_play/core/widgets/top_snackbar.dart';
import 'package:book_and_play/features/auth/presentation/manager/signin_cubit/signin_cubit.dart';
import 'package:book_and_play/features/auth/presentation/manager/signin_cubit/signin_state.dart';
import 'package:book_and_play/features/auth/presentation/widgets/sign_in_view_body.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as String;
    return BlocProvider(
      create: (context) => SigninCubit(),
      child: Scaffold(
        body: BlocListener<SigninCubit, SigninState>(
          listener: (context, state) {
            if (state is SigninFailureState) {
              TopSnackBar.show(
                context,
                title: 'log.error'.tr(),
                message: 'log.check_credentials'.tr(),
                contentType: ContentType.failure,
                color: Colors.red,
              );
            }
            if (state is SigninSuccessState) {
              state.user.role == 'player'
                  ? Navigator.pushReplacementNamed(
                      context,
                      Routes.userBottomNavView,
                    )
                  : Navigator.pushReplacementNamed(
                      context,
                      Routes.ownerBottomNavView,
                    );
            }
          },
          child: SignInViewBody(userRole: args),
        ),
      ),
    );
  }
}
