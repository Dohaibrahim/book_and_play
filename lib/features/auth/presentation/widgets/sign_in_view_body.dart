import 'dart:developer';

import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/core/routing/routes.dart';
import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/core/widgets/app_button.dart';
import 'package:book_and_play/core/widgets/app_text_form_field.dart';
import 'package:book_and_play/core/widgets/password_text_form_field.dart';
import 'package:book_and_play/features/auth/data/model/signin_req_params.dart';
import 'package:book_and_play/features/auth/domain/usecase/signin_usecase.dart';
import 'package:book_and_play/features/auth/presentation/manager/signin_cubit/signin_cubit.dart';
import 'package:book_and_play/features/auth/presentation/manager/signin_cubit/signin_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInViewBody extends StatefulWidget {
  const SignInViewBody({super.key, required this.userRole});
  final String userRole;
  @override
  State<SignInViewBody> createState() => _SignInViewBodyState();
}

class _SignInViewBodyState extends State<SignInViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  late String email, password;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: formKey,
        autovalidateMode: autovalidateMode,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //SizedBox(height: screenHeight * 0.20),
              Image.asset('assets/images/onboarding_players.png'),
              SizedBox(
                child: Text(
                  'signin.title'.tr(),
                  style: TextStyles.font32BlockBold,
                  // style: TextStyles.font32PrimaryExtraBold,
                ),
              ),
              const SizedBox(height: 20),

              SizedBox(height: 16),
              AppTextFormField(
                hintText: 'signin.email'.tr(),
                onSaved: (value) {
                  email = value!;
                  log(email);
                },
              ),
              SizedBox(height: 16),
              PasswordTextFormField(
                onSaved: (value) {
                  password = value!;
                },
              ),
              SizedBox(height: screenHeight * 0.10),
              BlocBuilder<SigninCubit, SigninState>(
                builder: (context, state) {
                  return Center(
                    child: AppButton(
                      text: 'signin.button'.tr(),
                      height: 45,
                      buttonWidth: screenWidth * 0.75,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          context.read<SigninCubit>().signin(
                            usecase: getIt<SigninUsecase>(),
                            params: SigninReqParams(
                              email: email,
                              password: password,
                            ),
                          );
                        }
                      },
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'signin.no_account'.tr(),
                        style: TextStyles.font14BlackMedium,
                      ),
                      TextButton(
                        style: ButtonStyle(
                          minimumSize: WidgetStateProperty.all(Size.zero),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          padding: WidgetStateProperty.all<EdgeInsets>(
                            EdgeInsets.zero,
                          ),
                          overlayColor: WidgetStateProperty.all(
                            Colors.transparent,
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            'signin.signup'.tr(),
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: ColorManager.primaryColor,
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                            context,
                            Routes.signUpView,
                            arguments: widget.userRole,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
