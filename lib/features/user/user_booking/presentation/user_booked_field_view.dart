import 'package:book_and_play/features/user/user_booking/data/models/user_matches_res.dart';
import 'package:book_and_play/features/user/user_booking/presentation/widgets/user_booked_field_view_body.dart';
import 'package:flutter/material.dart';

class UserBookedFieldView extends StatelessWidget {
  const UserBookedFieldView({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as UserMatchModel;
    return Scaffold(body: UserBookedFieldViewBody(userMatchModel: args));
  }
}
