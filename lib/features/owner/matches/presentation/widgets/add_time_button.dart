import 'package:book_and_play/core/routing/routes.dart';
import 'package:book_and_play/core/widgets/app_button.dart';
import 'package:book_and_play/features/owner/owner_fields/data/models/owner_fields.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AddTimeButton extends StatelessWidget {
  const AddTimeButton({super.key, required this.ownerField});
  final OwnerField ownerField;

  @override
  Widget build(BuildContext context) {
    return AppButton(
      onPressed: () {
        Navigator.pushNamed(
          context,
          Routes.scheduleMatchView,
          arguments: ownerField,
        );
      },
      text: context.tr('add_time_button'),
      textStyle: TextStyle(fontSize: 17),
    );
  }
}
