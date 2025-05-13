import 'package:book_and_play/core/routing/routes.dart';
import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:book_and_play/features/auth/presentation/manager/signin_cubit/signin_cubit.dart';
import 'package:book_and_play/features/auth/presentation/manager/signin_cubit/signin_state.dart';
import 'package:book_and_play/features/auth/presentation/widgets/sign_in_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SigninCubit(),
      child: Scaffold(
        body: BlocListener<SigninCubit, SigninState>(
          listener: (context, state) {
            if (state is SigninSuccessState) {
              Navigator.pushReplacementNamed(context, Routes.bottomNavView);
            }
            if (state is SigninLoadingState) {
              CircularProgressIndicator(color: ColorManager.primaryColor);
            }
          },
          child: SignInViewBody(),
        ),
      ),
    );
  }
}
