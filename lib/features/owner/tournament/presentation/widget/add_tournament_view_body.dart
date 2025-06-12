import 'dart:developer';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:book_and_play/core/widgets/app_button.dart';
import 'package:book_and_play/core/widgets/app_text_form_field.dart';
import 'package:book_and_play/core/widgets/top_snackbar.dart';
import 'package:book_and_play/features/owner/owner_fields/data/models/owner_fields.dart';
import 'package:book_and_play/features/owner/owner_fields/presentation/manager/owner_field_cubit.dart';
import 'package:book_and_play/features/owner/tournament/presentation/widget/add_field_drop_button.dart';
import 'package:book_and_play/features/owner/tournament/presentation/widget/date_range_dialog.dart';
import 'package:book_and_play/features/owner/tournament/presentation/widget/private_public_checkbox.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';

class AddTournamentViewBody extends StatefulWidget {
  const AddTournamentViewBody({super.key});

  @override
  State<AddTournamentViewBody> createState() => _AddTournamentViewBodyState();
}

class _AddTournamentViewBodyState extends State<AddTournamentViewBody> {
  GlobalKey<FormState> formKey = GlobalKey();
  String tournamentName = '', describtion = '', institutionName = '';
  String? numOfTeamsValue;
  DateTime startDate = DateTime.now().subtract(Duration(days: 365));
  DateTime endDate = DateTime.now().add(Duration(days: 365));
  DatePeriod selectedPeriod = DatePeriod(
    DateTime.now().subtract(Duration(days: 7)),
    DateTime.now(),
  );
  DatePeriod? newRange;
  bool isPublicSelected = false;
  bool isPrivateSelected = false;
  OwnerField? selectedField;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: screenHeight * 0.12),
              Text(
                'Create a tournament',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: screenHeight * 0.02),
              AppTextFormField(
                hintText: 'tournament name',
                onSaved: (data) {
                  tournamentName = data!;
                },
              ),
              SizedBox(height: screenHeight * 0.01),
              AppTextFormField(
                hintText: ' description',
                onSaved: (data) {
                  describtion = data!;
                },
              ),
              SizedBox(height: screenHeight * 0.01),
              DropdownButtonHideUnderline(
                child: DropdownButton2(
                  isExpanded: true,
                  hint: Text('number of teams'),
                  items:
                      ['8', '16']
                          .map(
                            (item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            ),
                          )
                          .toList(),
                  value: numOfTeamsValue,
                  onChanged: (value) {
                    setState(() {
                      numOfTeamsValue = value as String;
                    });
                  },
                  buttonStyleData: ButtonStyleData(
                    height: 50,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.transparent),
                      color: Colors.grey[200],
                    ),
                  ),
                  dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              MaterialButton(
                color: Colors.grey[200],
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                height: 45,
                onPressed: () {
                  showDateRangeDialog(
                    context: context,
                    selectedPeriod: selectedPeriod,
                    onApply: (newPeriod) {
                      setState(() {
                        selectedPeriod = newPeriod;
                        newRange = newPeriod;
                      });
                      log(
                        "Selected: ${selectedPeriod.start} → ${selectedPeriod.end}",
                      );
                    },
                  );
                },
                child: Text(
                  'pick date',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  PrivatePublicCheckBox(
                    text: 'public',
                    onChanged: (value) {
                      setState(() {
                        isPublicSelected = true;
                        isPrivateSelected = false;
                      });
                    },
                    screenWidth: screenWidth,
                    value: isPublicSelected,
                  ),
                  PrivatePublicCheckBox(
                    text: 'private',
                    onChanged: (value) {
                      setState(() {
                        isPrivateSelected = true;
                        isPublicSelected = false;
                      });
                    },
                    screenWidth: screenWidth,
                    value: isPrivateSelected,
                  ),
                ],
              ),
              AppTextFormField(
                hintText: 'Institution Name',
                onSaved: (data) {
                  institutionName = data!;
                },
              ),
              SizedBox(height: screenHeight * 0.01),
              BlocProvider(
                create: (context) => OwnerFieldCubit(),
                child: AddFieldDropButton(
                  onChanged: (value) {
                    selectedField = value;
                    log(selectedField.toString());
                  },
                  value: selectedField,
                ),
              ),
              //Expanded(child: SizedBox()),
              SizedBox(height: screenHeight * 0.30),
              AppButton(
                onPressed: () {
                  if (formKey.currentState!.validate() &&
                      newRange != null &&
                      selectedField != null) {
                    formKey.currentState!.save();
                    if (isPublicSelected == true || isPrivateSelected == true) {
                      Navigator.pop(context);
                      TopSnackBar.show(
                        context,
                        title: 'Done',
                        message: 'You are added a tournament successfully!',
                        contentType: ContentType.success,
                        color: Color(0xff58997F),
                      );
                    }
                  }
                  /*if (tournamentName.isNotEmpty &&
                      numOfTeamsValue.isNotEmpty &&
                      newRange != null &&
                      institutionName.isNotEmpty &&
                      selectedField != null) {
                    if (isPublicSelected == true ||
                        isPrivateSelected == true) {}
                  } */
                },
                text: 'Submit',
                textStyle: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
