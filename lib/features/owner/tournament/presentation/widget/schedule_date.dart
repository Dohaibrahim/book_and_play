import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/core/widgets/app_button.dart';
import 'package:book_and_play/core/widgets/top_snackbar.dart';
import 'package:book_and_play/features/owner/tournament/presentation/widget/show_hour_range.dart';
import 'package:flutter/material.dart';

class ScheduleDate extends StatefulWidget {
  const ScheduleDate({
    super.key,
    required this.numOfTeams,
    required this.onSubmit,
  });
  final int numOfTeams;
  final void Function(List<MatchTimeEntity>) onSubmit;

  @override
  State<ScheduleDate> createState() => _ScheduleDateState();
}

class _ScheduleDateState extends State<ScheduleDate> {
  late List<MatchTimeEntity?> matchTimes;
  @override
  void initState() {
    super.initState();
    int matchCount = (widget.numOfTeams / 2).toInt();
    matchTimes = List.generate(matchCount, (_) => null);
  }

  void updateTime(int index, MatchTimeEntity time) {
    setState(() {
      matchTimes[index] = time;
    });
  }

  void saveAndPop() {
    if (matchTimes.any((t) => t == null)) {
      return TopSnackBar.show(
        context,
        title: 'There are value missed',
        message: 'Please select times for all matches.',
        contentType: ContentType.warning,
        color: Colors.orange[600]!,
      );
    }
    widget.onSubmit(matchTimes.cast<MatchTimeEntity>());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 5,
              width: 75,
              decoration: BoxDecoration(
                color: Colors.grey,
                border: Border.all(color: Colors.transparent),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Set Time To Each Match ',
            style: TextStyles.font32BlockBold.copyWith(
              color: ColorManager.primaryColor,
              fontSize: 25,
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: (widget.numOfTeams / 2).toInt(),
              itemBuilder: (context, index) {
                return ShowHourRange(
                  initialTime: matchTimes[index],
                  onSelected: (time) => updateTime(index, time),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          AppButton(
            onPressed: () {
              saveAndPop();
            },
            text: 'Start The Next Round',
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
