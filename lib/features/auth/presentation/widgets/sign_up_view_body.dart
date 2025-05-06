import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/core/widgets/app_button.dart';
import 'package:book_and_play/core/widgets/app_text_form_field.dart';
import 'package:book_and_play/core/widgets/password_text_form_field.dart';
import 'package:flutter/material.dart';

class SignUpViewBody extends StatefulWidget {
  const SignUpViewBody({super.key});

  @override
  State<SignUpViewBody> createState() => _SignUpViewBodyState();
}

class _SignUpViewBodyState extends State<SignUpViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  late String email, userName, password, confirmPassword;

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
              SizedBox(height: screenHeight * 0.1),
              SizedBox(
                child: Text(
                  'create an account',
                  style: TextStyles.font32BlockBold,
                  // style: TextStyles.font32PrimaryExtraBold,
                ),
              ),
              const SizedBox(height: 20),
              AppTextFormField(
                hintText: 'Name',
                onSaved: (value) {
                  userName = value!;
                },
              ),
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
              SizedBox(height: 16),
              PasswordTextFormField(
                onSaved: (value) {
                  confirmPassword = value!;
                },
              ),
              SizedBox(height: 25),
              Center(
                child: AppButton(
                  text: 'Sign Up',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                    } else {}
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already Have An Account ?',
                        style: TextStyles.font14BlackMedium,
                      ),

                      TextButton(
                        child: Text(
                          'login',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: ColorManager.primaryColor,
                          ),
                        ),
                        onPressed: () {
                          //Navigator.pushReplacementNamed(context, Routes.loginScreen);
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
