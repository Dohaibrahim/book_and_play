import 'package:book_and_play/features/user/settings/presentation/widgets/about_us_view_body.dart';
import 'package:flutter/material.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About Us',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: AboutUsViewBody(),
    );
  }
}
