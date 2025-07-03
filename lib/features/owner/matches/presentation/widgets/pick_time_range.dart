import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:book_and_play/core/widgets/app_button.dart';
import 'package:book_and_play/core/widgets/top_snackbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PickTimeRangeButton extends StatelessWidget {
  const PickTimeRangeButton({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.onStartTimePicked,
    required this.onEndTimePicked,
  });

  final TimeOfDay? startTime;
  final TimeOfDay? endTime;
  final void Function(TimeOfDay) onStartTimePicked;
  final void Function(TimeOfDay) onEndTimePicked;

  int _compareTime(TimeOfDay a, TimeOfDay b) {
    return (a.hour * 60 + a.minute) - (b.hour * 60 + b.minute);
  }

  String _formatTime(TimeOfDay? time) {
    if (time == null) return '--:--';
    final h = time.hour.toString().padLeft(2, '0');
    final m = time.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    Future<void> _pickStartTime() async {
      final picked = await showTimePicker(
        context: context,
        initialTime: startTime ?? TimeOfDay(hour: 17, minute: 0),
      );
      if (picked != null) {
        onStartTimePicked(picked);
      }
    }

    Future<void> _pickEndTime() async {
      if (startTime == null) {
        TopSnackBar.show(
          context,
          title: context.tr('warning_title'),
          message: context.tr('pick_start_time_warning'),
          contentType: ContentType.warning,
          color: Colors.orange,
        );
        return;
      }

      final picked = await showTimePicker(
        context: context,
        initialTime: startTime!.replacing(hour: startTime!.hour + 1),
      );

      if (picked != null && _compareTime(picked, startTime!) > 0) {
        onEndTimePicked(picked);
      } else {
        TopSnackBar.show(
          context,
          title: context.tr('warning_title'),
          message: context.tr('pick_start_time_warning'),
          contentType: ContentType.warning,
          color: Colors.orange,
        );
      }
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: screenWidth * 0.15,
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  context.tr('from_label'),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  context.tr('to_label'),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(width: 12),
          SizedBox(
            height: 100,
            width: screenWidth * 0.65,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TimeButton(
                  onPressed: _pickStartTime,
                  text: startTime == null
                      ? context.tr('pick_start_time_button')
                      : _formatTime(startTime),
                ),
                TimeButton(
                  onPressed: _pickEndTime,
                  text: endTime == null
                      ? context.tr('pick_start_time_button')
                      : _formatTime(endTime),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TimeButton extends StatelessWidget {
  const TimeButton({super.key, required this.onPressed, required this.text});
  final void Function()? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: AppButton(
        onPressed: onPressed,
        text: text,
        buttonWidth: 100,
        buttonColor: Colors.grey[200],
        textStyle: TextStyle(color: Colors.black, fontSize: 17),
      ),
    );
  }
}
