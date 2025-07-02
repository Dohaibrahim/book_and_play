import 'dart:developer';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/core/widgets/app_button.dart';
import 'package:book_and_play/core/widgets/app_text_form_field.dart';
import 'package:book_and_play/core/widgets/top_snackbar.dart';
import 'package:book_and_play/features/owner/matches/data/models/create_match_req.dart';
import 'package:book_and_play/features/owner/matches/presentation/manager/create_match/create_match_cubit.dart';
import 'package:book_and_play/features/owner/matches/presentation/manager/create_match/create_match_state.dart';
import 'package:book_and_play/features/owner/matches/presentation/widgets/add_players.dart';
import 'package:book_and_play/features/owner/matches/presentation/widgets/create_match_bloc_builder.dart';
import 'package:book_and_play/features/owner/owner_fields/data/models/owner_fields.dart';
import 'package:book_and_play/features/owner/matches/presentation/widgets/pick_time_range.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ScheduleMatchViewBody extends StatefulWidget {
  const ScheduleMatchViewBody({super.key, required this.ownerField});
  final OwnerField ownerField;

  @override
  State<ScheduleMatchViewBody> createState() => _ScheduleMatchViewBodyState();
}

class _ScheduleMatchViewBodyState extends State<ScheduleMatchViewBody> {
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  int? playersNum;
  DateTime? pickedDate;
  List<String> currentPlayers = [];
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.20),
                  Text(
                    'Schedule a match for ${widget.ownerField.name}',
                    style: TextStyles.font24BlackBold,
                  ),
                  SizedBox(height: screenHeight * 0.07),
                  AppTextFormField(
                    hintText: 'Max number of players at each team',
                    onSaved: (data) {
                      playersNum = int.parse(data ?? '0');
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                  SizedBox(height: 20),
                  AppButton(
                    onPressed: () => _pickDate(context),
                    text: pickedDate == null
                        ? 'Pick a Date'
                        : formatDate(pickedDate!),
                    buttonColor: Colors.blueGrey[500],
                    textStyle: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  PickTimeRangeButton(
                    startTime: startTime,
                    endTime: endTime,
                    onStartTimePicked: (time) =>
                        setState(() => startTime = time),
                    onEndTimePicked: (time) => setState(() => endTime = time),
                  ),
                  SizedBox(height: 20),
                  AddPlayersWidget(
                    onPlayersChanged: (ids) {
                      setState(() {
                        currentPlayers = ids;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Note : This date will be available for players weekly',
                    style: TextStyles.font14BlackMedium.copyWith(
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(child: SizedBox()),
          CreateMatchButton(
            startTime: startTime,
            endTime: endTime,
            playersNum: playersNum,
            pickedDate: pickedDate,
            currentPlayers: currentPlayers,
            formKey: formKey,
            ownerField: widget.ownerField,
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }

  String formatTimeOfDay(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  Future<void> _pickDate(BuildContext context) async {
    final now = DateTime.now();
    final next7Days = now.add(Duration(days: 7));
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: next7Days,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: ColorManager.primaryColor,
              onPrimary: Colors.white,
              onSurface: ColorManager.textColor,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: ColorManager.primaryColor,
              ),
            ),
            dialogTheme: DialogThemeData(backgroundColor: Colors.white),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      setState(() {
        this.pickedDate = pickedDate;
      });
      log('User selected: ${formatDate(pickedDate)}');
    }
  }

  String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }
}
