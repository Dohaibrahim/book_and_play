import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/core/widgets/app_button.dart';
import 'package:book_and_play/core/widgets/password_text_form_field.dart';
import 'package:book_and_play/features/settings/data/models/change_pass_req.dart';
import 'package:book_and_play/features/settings/presentation/manager/change_pass_cubit/change_pass_cubit.dart';
import 'package:book_and_play/features/settings/presentation/manager/change_pass_cubit/change_pass_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordViewBody extends StatefulWidget {
  const ChangePasswordViewBody({super.key, required this.userEmail});
  final String userEmail;
  @override
  State<ChangePasswordViewBody> createState() => _ChangePasswordViewBodyState();
}

class _ChangePasswordViewBodyState extends State<ChangePasswordViewBody> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? oldPass, newPass;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: screenHeight * 0.15),
              Text(
                'Change Your Password',
                style: TextStyles.font32BlockBold.copyWith(fontSize: 25),
              ),
              SizedBox(height: 50),
              PasswordTextFormField(
                hintText: 'Old password',
                onSaved: (data) {
                  oldPass = data;
                },
              ),
              SizedBox(height: 15),
              PasswordTextFormField(
                hintText: 'New password',
                onSaved: (data) {
                  newPass = data;
                },
              ),
              SizedBox(height: screenHeight * 0.40),
              BlocBuilder<ChangePassCubit, ChangePassState>(
                builder: (context, state) {
                  if (state is ChangePassLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: ColorManager.primaryColor,
                      ),
                    );
                  }
                  return AppButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        context.read<ChangePassCubit>().changePass(
                          ChangePassReq(
                            email: widget.userEmail,
                            oldPassword: oldPass!,
                            newPassword: newPass!,
                          ),
                        );
                      }
                    },
                    text: 'Change Password',
                    textStyle: TextStyle(fontSize: 20),
                  );
                },
              ),

              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
