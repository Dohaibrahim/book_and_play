import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/features/booking/presentation/widgets/book_now_view_body.dart';
import 'package:flutter/material.dart';

class BookNowView extends StatelessWidget {
  const BookNowView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Royal Kings School',
          style: TextStyles.font24BlackBold.copyWith(fontSize: 20),
        ),
      ),
      body: BookNowViewBody(),
    );
  }
}
