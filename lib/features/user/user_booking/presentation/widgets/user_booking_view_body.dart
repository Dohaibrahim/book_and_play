import 'package:book_and_play/features/user/user_booking/presentation/widgets/filter_booking_by_date.dart';
import 'package:book_and_play/features/user/user_booking/presentation/widgets/stadium_card.dart';
import 'package:flutter/material.dart';

class UserBookingViewBody extends StatelessWidget {
  const UserBookingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    return Column(
      children: [
        SizedBox(height: screenHeight * 0.12),
        FilterBookingByDate(),
        SizedBox(height: screenHeight * 0.03),
        Expanded(child: StadiumCardListView()),
      ],
    );
  }
}
