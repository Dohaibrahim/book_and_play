import 'package:book_and_play/core/routing/routes.dart';
import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/core/widgets/app_button.dart';
import 'package:book_and_play/core/widgets/app_text_form_field.dart';
import 'package:book_and_play/core/widgets/password_text_form_field.dart';
import 'package:flutter/material.dart';

class SignInViewBody extends StatefulWidget {
  const SignInViewBody({super.key});

  @override
  State<SignInViewBody> createState() => _SignInViewBodyState();
}

class _SignInViewBodyState extends State<SignInViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  late String email, userName, password;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: formKey,
        autovalidateMode: autovalidateMode,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.20),
              SizedBox(
                child: Text(
                  'Sign in to your account',
                  style: TextStyles.font32BlockBold,
                  // style: TextStyles.font32PrimaryExtraBold,
                ),
              ),
              const SizedBox(height: 20),

              SizedBox(height: 16),
              AppTextFormField(
                hintText: 'Email',
                onSaved: (value) {
                  email = value!;
                },
              ),
              SizedBox(height: 16),
              PasswordTextFormField(
                onSaved: (value) {
                  password = value!;
                },
              ),
              SizedBox(height: screenHeight * 0.10),
              Center(
                child: AppButton(
                  text: 'Sign In',
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                      context,
                      Routes.bottomNavView,
                    );
                    /*if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                    } else {}*/
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account ? ',
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
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: ColorManager.primaryColor,
                            ),
                          ),
                        ),
                        onPressed: () {},
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
