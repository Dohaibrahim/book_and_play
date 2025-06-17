import 'dart:developer';
import 'package:book_and_play/core/widgets/app_button.dart';
import 'package:book_and_play/core/widgets/app_text_form_field.dart';
import 'package:book_and_play/features/owner/owner_fields/data/models/owner_fields.dart';
import 'package:book_and_play/features/owner/tournament/data/models/add_tournament_req.dart';
import 'package:book_and_play/features/owner/tournament/presentation/manager/add_tounament_cubit/add_tournament_cubit.dart';
import 'package:book_and_play/features/owner/tournament/presentation/manager/add_tounament_cubit/add_tournament_state.dart';
import 'package:book_and_play/features/owner/tournament/presentation/widget/add_field_drop_button.dart';
import 'package:book_and_play/features/owner/tournament/presentation/widget/date_range_dialog.dart';
import 'package:book_and_play/features/owner/tournament/presentation/widget/number_of_teams.dart';
import 'package:book_and_play/features/owner/tournament/presentation/widget/private_public_checkbox.dart';
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
  List<String>? fieldIds;
  String? numOfTeamsValue;

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
                hintText: 'description',
                onSaved: (data) {
                  describtion = data!;
                },
              ),
              SizedBox(height: screenHeight * 0.01),
              NumberOfTeams(
                value: numOfTeamsValue,
                onChanged: (value) {
                  numOfTeamsValue = value;
                  setState(() {});
                },
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
                        startDate = DateTime(
                          selectedPeriod.start.year,
                          selectedPeriod.start.month,
                          selectedPeriod.start.day,
                        );
                        endDate = DateTime(
                          selectedPeriod.end.year,
                          selectedPeriod.end.month,
                          selectedPeriod.end.day,
                        );
                        newRange = newPeriod;
                      });
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
              AddFieldDropButton(
                onChanged: (value) {
                  selectedField = value;
                  fieldIds?.add(value!.id);
                  log(selectedField!.id.toString());
                  setState(() {});
                },
                value: selectedField,
              ),
              SizedBox(height: screenHeight * 0.30),
              BlocBuilder<AddTournamentCubit, AddTournamentState>(
                builder: (context, state) {
                  log(selectedField.toString());
                  return AppButton(
                    onPressed: () {
                      if (formKey.currentState!.validate() &&
                          newRange != null &&
                          selectedField != null &&
                          numOfTeamsValue != null) {
                        formKey.currentState!.save();
                        log(
                          'tournamentName : $tournamentName , desc : $describtion , startDate : $startDate , end date : $endDate , maxTeams : ${int.parse(numOfTeamsValue!)} , fieldIds :  ${[selectedField!.id.toString()]} , isPrivate: $isPrivateSelected  , institution: $institutionName , ',
                        );
                        if (isPublicSelected == true ||
                            isPrivateSelected == true) {
                          context.read<AddTournamentCubit>().addTournament(
                            request: AddTournamentReq(
                              name: tournamentName,
                              description: describtion,
                              startDate: startDate,
                              endDate: endDate,
                              maxTeams: int.parse(numOfTeamsValue!),
                              fieldIds: [selectedField!.id.toString()],
                              isPrivate: isPrivateSelected,
                              institution: institutionName,
                              type: "knockout",
                            ),
                          );
                        }
                      }
                    },
                    text: 'Submit',
                    textStyle: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
