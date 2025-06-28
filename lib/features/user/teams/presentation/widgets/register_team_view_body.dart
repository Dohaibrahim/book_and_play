import 'dart:developer';
import 'dart:io' as file;
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:book_and_play/core/routing/routes.dart';
import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/core/widgets/app_button.dart';
import 'package:book_and_play/core/widgets/app_text_form_field.dart';
import 'package:book_and_play/core/widgets/top_snackbar.dart';
import 'package:book_and_play/features/user/teams/data/models/team_create_req.dart';
import 'package:book_and_play/features/user/teams/presentation/manager/player_team_cubit/player_team_cubit.dart';
import 'package:book_and_play/features/user/teams/presentation/manager/player_team_cubit/player_team_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class RegisterTeamViewBody extends StatefulWidget {
  const RegisterTeamViewBody({super.key});

  @override
  State<RegisterTeamViewBody> createState() => _RegisterTeamViewBodyState();
}

class _RegisterTeamViewBodyState extends State<RegisterTeamViewBody> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? teamName;
  file.File? image;
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        image = file.File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as String;
    log(args);
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;
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
            AppTextFormField(
              hintText: 'team name',
              onSaved: (data) {
                teamName = data;
              },
            ),
            SizedBox(height: 15),
            MaterialButton(
              height: 45,
              minWidth: screenWidth * 0.80,
              color: Colors.grey[300],
              onPressed: _pickImage,
              shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              child: Text(
                'Pick a logo of your team',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.26),
            BlocBuilder<PlayerTeamCubit, PlayerTeamState>(
              builder: (context, state) {
                if (state is PlayerTeamLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: ColorManager.primaryColor,
                    ),
                  );
                }
                return AppButton(
                  onPressed: () {
                    if (formKey.currentState!.validate() && image != null) {
                      formKey.currentState!.save();
                      context.read<PlayerTeamCubit>().createTeam(
                        CreateTeamRequest(
                          name: teamName!,
                          tournamentId: args,
                          logo: image!,
                        ),
                      );
                    } else {
                      TopSnackBar.show(
                        context,
                        title: 'Data required',
                        message: 'please make sure to fill all data',
                        contentType: ContentType.failure,
                        color: Colors.orange,
                      );
                    }
                  },
                  text: 'Next',
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
