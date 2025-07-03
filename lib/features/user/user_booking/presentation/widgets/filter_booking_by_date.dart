import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class FilterBookingByDate extends StatefulWidget {
  const FilterBookingByDate({super.key});

  @override
  State<FilterBookingByDate> createState() => _FilterBookingByDateState();
}

class _FilterBookingByDateState extends State<FilterBookingByDate> {
  final List<String> filters = [
    'filter.next_week'.tr(),
    'filter.today'.tr(),
    'filter.three_days'.tr(),
    'filter.last_week'.tr(),
    'filter.last_month'.tr(),
  ];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        padding: EdgeInsets.symmetric(horizontal: 12),
        itemBuilder: (context, index) {
          final isSelected = index == selectedIndex;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[],
                  color: isSelected
                      ? ColorManager.primaryColor
                      : Color(0xffDEF0E8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    filters[index],
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
