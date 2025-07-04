import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ShowHourRange extends StatefulWidget {
  const ShowHourRange({super.key, required this.onSelected, this.initialTime});
  final void Function(MatchTimeEntity) onSelected;
  final MatchTimeEntity? initialTime;
  @override
  State<ShowHourRange> createState() => _ShowHourRangeState();
}

class _ShowHourRangeState extends State<ShowHourRange> {
  TimeOfDay? selectedTime;

  @override
  void initState() {
    super.initState();
    selectedTime = widget.initialTime?.from;
  }

  @override
  Widget build(BuildContext context) {
    TimeOfDay endTime = selectedTime == null
        ? TimeOfDay(hour: 0, minute: 0)
        : TimeOfDay(
            hour: (selectedTime!.hour + 1) % 24,
            minute: selectedTime!.minute,
          );

    return Padding(
      padding: EdgeInsetsGeometry.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            context.tr('show_hour_range.from'),
            style: TextStyles.font24BlackBold.copyWith(fontSize: 18),
          ),
          SizedBox(
            width: 140,
            height: 45,
            child: GestureDetector(
              onTap: () {
                selectedTime == null
                    ? showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      )
                    : showTimePicker(
                        context: context,
                        initialTime: selectedTime!,
                      );
              },
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff58997F),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                onPressed: () async {
                  final picked = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (picked != null) {
                    setState(() {
                      selectedTime = picked;
                    });
                    widget.onSelected(
                      MatchTimeEntity(from: picked, to: endTime),
                    );
                  }
                },
                child: Center(
                  child: Text(
                    selectedTime == null
                        ? context.tr('show_hour_range.select')
                        : selectedTime!.format(context),
                    style: TextStyle(
                      fontSize: selectedTime == null ? 13 : 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Text(
            context.tr('show_hour_range.to'),
            style: TextStyles.font24BlackBold.copyWith(fontSize: 18),
          ),
          Container(
            width: 140,
            height: 45,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: Text(
                selectedTime == null ? '00:00' : endTime.format(context),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MatchTimeEntity {
  final TimeOfDay from;
  final TimeOfDay to;

  MatchTimeEntity({required this.from, required this.to});
  String formatTimeOfDay24(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  String get fromFormatted => formatTimeOfDay24(from);
  String get toFormatted => formatTimeOfDay24(to);
}
