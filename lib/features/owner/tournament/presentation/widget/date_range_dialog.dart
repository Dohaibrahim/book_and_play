import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';

Future<void> showDateRangeDialog({
  required BuildContext context,
  required DatePeriod selectedPeriod,
  required void Function(DatePeriod) onApply,
}) async {
  DateTime firstDate = DateTime.now().subtract(Duration(days: 365));
  DateTime lastDate = DateTime.now().add(Duration(days: 365));
  DatePeriod tempPeriod = selectedPeriod;

  await showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Select Date Range'),
            content: SizedBox(
              height: 300,
              width: 300,
              child: RangePicker(
                selectedPeriod: tempPeriod,
                onChanged: (DatePeriod newPeriod) {
                  setState(() {
                    tempPeriod = newPeriod;
                  });
                },
                firstDate: firstDate,
                lastDate: lastDate,
                datePickerStyles: DatePickerRangeStyles(
                  selectedPeriodStartDecoration: BoxDecoration(
                    color: const Color(0xff58997F),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                  selectedPeriodLastDecoration: BoxDecoration(
                    color: const Color(0xff58997F),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  selectedPeriodMiddleDecoration: BoxDecoration(
                    color: const Color(0xff58997F).withAlpha(100),
                    shape: BoxShape.rectangle,
                  ),
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                    color: Color(0xff58997F),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  onApply(tempPeriod); // Pass the result back
                  Navigator.pop(context);
                },
                child: const Text(
                  "Apply",
                  style: TextStyle(
                    color: Color(0xff58997F),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          );
        },
      );
    },
  );
}
