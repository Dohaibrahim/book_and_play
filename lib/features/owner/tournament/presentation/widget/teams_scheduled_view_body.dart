import 'dart:developer';

import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/core/widgets/app_button.dart';
import 'package:book_and_play/features/owner/tournament/presentation/widget/tournament_card.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TeamsScheduledViewBody extends StatefulWidget {
  const TeamsScheduledViewBody({super.key});

  @override
  State<TeamsScheduledViewBody> createState() => _TeamsScheduledViewBodyState();
}

class _TeamsScheduledViewBodyState extends State<TeamsScheduledViewBody> {
  DateTime? pickedStartDate, pickedEndDate;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: screenHeight * 0.10),
          Text('First Round', style: TextStyles.font32BlockBold),
          SizedBox(height: 15),
          GestureDetector(
            onTap: () async {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return PickTimeBottomSheet();
                },
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              height: 180,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.transparent),
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/match_card1.png'),
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.10),
                    offset: Offset(0, 5),
                    blurRadius: 8,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Team 1 ',
                    style: TextStyles.font24BlackBold.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Group 1',
                        style: TextStyles.font14BlackMedium.copyWith(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 1),
                      Text(
                        'Schedule a date',
                        style: TextStyles.font14BlackMedium.copyWith(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                  Text(
                    'Team 2 ',
                    style: TextStyles.font24BlackBold.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          //ScheduleMatch(),
          Expanded(child: SizedBox()),
          AppButton(onPressed: () {}, text: 'Start first round of matches'),
          SizedBox(height: screenHeight * 0.05),
        ],
      ),
    );
  }
}

class PickTimeBottomSheet extends StatefulWidget {
  const PickTimeBottomSheet({super.key});

  @override
  State<PickTimeBottomSheet> createState() => _PickTimeBottomSheetState();
}

class _PickTimeBottomSheetState extends State<PickTimeBottomSheet> {
  DateTime? pickedStartDate, pickedEndDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      height: 180,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.transparent),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppButton(
            onPressed: () async {
              pickedStartDate = await timeAndDatePicker(context);
              log('start date : ${pickedStartDate.toString()}');
            },
            text: 'Start date',
            textStyle: TextStyles.font24BlackBold.copyWith(fontSize: 17),
          ),
          AppButton(
            onPressed: () async {
              pickedEndDate = await timeAndDatePicker(context);
              log('end date : ${pickedEndDate.toString()}');
            },
            text: 'End date',
            textStyle: TextStyles.font24BlackBold.copyWith(fontSize: 17),
          ),

          //Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}

Future<DateTime?> timeAndDatePicker(BuildContext context) async {
  DateTime? selectedDateTime;

  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now().subtract(Duration(days: 1)),
    lastDate: DateTime.now().add(Duration(days: 365)),
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.dark().copyWith(
          colorScheme: ColorScheme.dark(
            primary:
                ColorManager
                    .primaryColor, // Replace with your app's primary color
            onPrimary: Colors.black,
            surface: Colors.white, // Background of the dialog
            onSurface: Colors.black,
          ),
          //dialogBackgroundColor: Color(0xFF2C2C2C), // Dialog background
        ),
        child: child!,
      );
    },
  );

  if (pickedDate != null) {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: ColorManager.primaryColor,
              onPrimary: Colors.black,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      selectedDateTime = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );
    }
  }

  return selectedDateTime;
}
