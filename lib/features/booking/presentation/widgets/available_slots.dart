import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:flutter/material.dart';

class AvailableSlotsListView extends StatefulWidget {
  const AvailableSlotsListView({super.key});

  @override
  State<AvailableSlotsListView> createState() => _AvailableSlotsListViewState();
}

class _AvailableSlotsListViewState extends State<AvailableSlotsListView> {
  int? selectedIndex;
  late final List<String> dates;

  @override
  void initState() {
    dates = [
      "9:00 - 10:00 pm ",
      "3:00 - 4:00 pm ",
      "7:00 - 8:00 pm ",
      "9:00 - 10:00 am ",
      "5:00 - 6:00 pm ",
      "9:00 - 10:00 pm ",
      "3:00 - 4:00 pm ",
      "7:00 - 8:00 pm ",
      "9:00 - 10:00 am ",
      "5:00 - 6:00 pm ",
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 10),
      itemCount: dates.length,
      itemBuilder: (BuildContext context, int index) {
        String hour = dates[index];
        final isSelected = selectedIndex == index;
        return SizedBox(
          height: 60,
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              decoration: BoxDecoration(
                color: isSelected ? ColorManager.primaryColor : Colors.white,
                // Color(0xffDEF0E8),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey),
              ),
              child: Text(
                hour,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
