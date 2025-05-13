import 'dart:developer';
import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/core/routing/routes.dart';
import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/core/widgets/app_button.dart';
import 'package:book_and_play/core/widgets/app_text_form_field.dart';
import 'package:book_and_play/core/widgets/password_text_form_field.dart';
import 'package:book_and_play/features/auth/data/model/signup_req_params.dart';
import 'package:book_and_play/features/auth/domain/usecase/signup_usecase.dart';
import 'package:book_and_play/features/auth/presentation/manager/signup_cubit/signup_cubit.dart';
import 'package:book_and_play/features/auth/presentation/manager/signup_cubit/signup_state.dart';
import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpViewBody extends StatefulWidget {
  const SignUpViewBody({super.key});

  @override
  State<SignUpViewBody> createState() => _SignUpViewBodyState();
}

class _SignUpViewBodyState extends State<SignUpViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late String email, userName, password, confirmPassword;
  bool isCountrySelected = false;
  String? countryName;
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
              Center(
                child: Image.asset(
                  'assets/images/onboarding_players.png',
                  width: 270,
                  height: 270,
                ),
              ),
              //SizedBox(height: screenHeight * 0.1),
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
              SizedBox(height: 16),
              AppButton(
                buttonColor: Colors.grey[700],
                buttonWidth: screenWidth * 0.90,
                onPressed: () {
                  showCountryPicker(
                    context: context,
                    onSelect: (Country country) async {
                      log('Select country: ${country.name}');
                      countryName = country.name;
                      countryName != null
                          ? isCountrySelected = true
                          : isCountrySelected = false;
                    },
                    onClosed: () {
                      countryName ??= '';
                    },
                  );
                },
                text: 'Select your country',
              ),
              SizedBox(height: screenHeight * 0.10),
              BlocBuilder<SignupCubit, SignupState>(
                builder: (context, state) {
                  return Center(
                    child: AppButton(
                      height: 45,
                      buttonWidth: screenWidth * 0.75,
                      text: 'Sign Up',
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          if (isCountrySelected == true) {
                            formKey.currentState!.save();
                            context.read<SignupCubit>().execute(
                              usecase: getIt<SignupUsecase>(),
                              params: SignupReqParams(
                                email: email,
                                country: countryName!,
                                password: password,
                                preferred_distance: 10,
                                location: Location(
                                  type: "Point",
                                  coordinates: [45.849, 55.266],
                                ),
                                name: userName,
                                repassword: confirmPassword,
                                role: 'player',
                              ),
                            );
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Center(
                                  child: Container(
                                    width: screenWidth * 0.70,
                                    height: screenHeight * 0.20,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/icons/football_icon.png',
                                          width: 50,
                                          height: 50,
                                        ),
                                        Text(
                                          'the country is required',
                                          style: TextStyles.font24BlackBold
                                              .copyWith(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        } else {}
                      },
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already Have An Account ?',
                        style: TextStyles.font14BlackMedium,
                      ),
                      TextButton(
                        style: ButtonStyle(
                          overlayColor: WidgetStateProperty.all(
                            Colors.transparent,
                          ),
                        ),
                        child: Text(
                          'login',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: ColorManager.primaryColor,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                            context,
                            Routes.signInView,
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
