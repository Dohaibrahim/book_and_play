import 'dart:developer';

import 'package:book_and_play/features/user/booking/presentation/manager/get_available_matches/get_available_matches_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class DataBookingSelection extends StatefulWidget {
  const DataBookingSelection({super.key});

  @override
  State<DataBookingSelection> createState() => _DataBookingSelectionState();
}

class _DataBookingSelectionState extends State<DataBookingSelection> {
  int? selectedIndex;
  late final List<DateTime> days;

  @override
  void initState() {
    super.initState();
    final today = DateTime.now();
    days = List.generate(7, (index) => today.add(Duration(days: index)));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: days.length,
      itemBuilder: (context, index) {
        final date = days[index];
        final formatted = DateFormat('EEEE, MMM d').format(date);
        final isSelected = selectedIndex == index;

        return SizedBox(
          height: 50,
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              final formattedDate = DateFormat(
                'yyyy-MM-dd',
              ).format(days[selectedIndex!]);
              log(formattedDate);
              context.read<GetAvailableMatchesCubit>().getAvailableMatches(
                formattedDate,
              );
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              decoration: BoxDecoration(
                color:
                    isSelected
                        ? Color(0xff4a5057)
                        : Colors.white, //  Color(0xffDEF0E8),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey),
              ),
              child: Text(
                formatted,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontSize: 15,
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
