import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:flutter/material.dart';

class AboutUsViewBody extends StatelessWidget {
  const AboutUsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Book And Play',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: ColorManager.primaryColor,
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          Text(
            '''Book and Play is your ultimate companion for organizing and enjoying football matches in your area. Whether you’re a player looking to join a game or a field owner managing stadium bookings, our app brings the football community together in one place.''',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: screenHeight * 0.01),
          Text(
            '''Players can easily discover and book matches at nearby stadiums, connect and chat with fellow teammates, and even take part in exciting championships to showcase their skills.''',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: screenHeight * 0.01),
          Text(
            '''For field owners, Book and Play offers a seamless platform to add stadium details, schedule matches, and manage bookings with ease—ensuring your fields are always active and visible to local players.''',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: screenHeight * 0.01),
          Text(
            '''Join a growing community that’s passionate about the game. With Book and Play, it’s never been easier to find a match, build your team, and enjoy the sport you love. ''',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
