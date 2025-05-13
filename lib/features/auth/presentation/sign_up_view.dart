import 'package:book_and_play/core/routing/routes.dart';
import 'package:book_and_play/features/auth/presentation/manager/signup_cubit/signup_cubit.dart';
import 'package:book_and_play/features/auth/presentation/manager/signup_cubit/signup_state.dart';
import 'package:book_and_play/features/auth/presentation/widgets/sign_up_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(),
      child: BlocListener<SignupCubit, SignupState>(
        listener: (context, state) {
          if (state is SignupSuccess) {
            Navigator.pushReplacementNamed(context, Routes.signInView);
          }
        },
        child: const Scaffold(body: SignUpViewBody()),
      ),
    );
  }
}
