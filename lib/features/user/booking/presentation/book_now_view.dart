import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/features/user/booking/presentation/widgets/book_now_view_body.dart';
import 'package:flutter/material.dart';

class BookNowView extends StatelessWidget {
  const BookNowView({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          args['fieldName'],
          style: TextStyles.font24BlackBold.copyWith(fontSize: 20),
        ),
      ),
      body: BookNowViewBody(fieldId: args['fieldId']),
    );
  }
}
