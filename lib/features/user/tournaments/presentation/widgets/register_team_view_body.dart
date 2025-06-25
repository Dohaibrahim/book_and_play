import 'package:book_and_play/core/routing/routes.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/core/widgets/app_button.dart';
import 'package:book_and_play/core/widgets/app_text_form_field.dart';
import 'package:flutter/material.dart';

class RegisterTeamViewBody extends StatefulWidget {
  const RegisterTeamViewBody({super.key});

  @override
  State<RegisterTeamViewBody> createState() => _RegisterTeamViewBodyState();
}

class _RegisterTeamViewBodyState extends State<RegisterTeamViewBody> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 15),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: screenHeight * 0.10),
            Image.asset('assets/images/register_team_image.png'),
            SizedBox(height: screenHeight * 0.05),
            Text(
              'Register your team',
              style: TextStyles.font24BlackBold,
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 40),
            AppTextFormField(hintText: 'team name'),
            SizedBox(height: 15),
            AppTextFormField(hintText: 'Add players IDs'),
            SizedBox(height: screenHeight * 0.26),
            AppButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.playersOfTeamView);
              },
              text: 'Next',
              textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
