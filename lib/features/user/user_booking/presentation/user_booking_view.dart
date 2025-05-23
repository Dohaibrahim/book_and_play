import 'package:book_and_play/features/user/user_booking/presentation/widgets/user_booking_view_body.dart';
import 'package:flutter/material.dart';

class UserBookingView extends StatelessWidget {
  const UserBookingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xfff8f8f8),
      body: UserBookingViewBody(),
    );
  }
}
