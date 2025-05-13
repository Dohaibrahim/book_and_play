import 'package:book_and_play/features/booking/presentation/widgets/available_slots.dart';
import 'package:book_and_play/features/booking/presentation/widgets/data_bokking_selection.dart';
import 'package:flutter/material.dart';

class BookNowViewBody extends StatelessWidget {
  const BookNowViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,

      children: [
        SizedBox(height: screenHeight * 0.07, child: DataBookingSelection()),
        SizedBox(height: screenHeight * 0.01),
        Expanded(child: AvailableSlotsListView()),
      ],
    );
  }
}
