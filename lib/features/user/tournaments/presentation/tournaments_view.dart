import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/features/user/tournaments/presentation/widgets/tournaments_view_body.dart';
import 'package:flutter/material.dart';

class TournamentsView extends StatelessWidget {
  const TournamentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Tournaments', style: TextStyles.font24BlackBold),
      ),
      body: TournamentsViewBody(),
    );
  }
}
