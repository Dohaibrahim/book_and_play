import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  const BookCard({
    super.key,
    required this.title,
    required this.subTitle,
    required this.trailing,
    this.onTap,
    required this.imagePath,
  });
  final String title, subTitle;
  final Widget trailing;
  final String imagePath;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final screenHight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final textDirection = Directionality.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: screenHight * 0.17,
        width: screenWidth * 0.85,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(imagePath), //'assets/images/blue_banner.png'),
            ),
            PositionedDirectional(
              start: 20,
              top: screenHight * 0.045,
              child: Text(
                title,
                textDirection: textDirection,
                style: TextStyles.font24BlackBold.copyWith(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
            ),
            PositionedDirectional(
              start: 20,
              top: screenHight * 0.085,
              child: Row(
                children: [
                  Text(
                    subTitle,
                    textDirection: textDirection,
                    style: TextStyles.font14BlackMedium.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  Icon(Icons.navigate_next_rounded, color: Colors.white),
                ],
              ),
            ),
            trailing,
            /*PositionedDirectional(
              end: 20,
              child: Image.asset(
                'assets/images/football_players.png',
                width: 130,
                height: 130,
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}

class BookNowListView extends StatelessWidget {
  const BookNowListView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;
    return SizedBox(
      height: screenHight * 0.17,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          BookCard(
            title: 'Book, Play, Win!',
            imagePath: 'assets/images/blue_banner.png',
            subTitle: 'Book Now ',
            trailing: PositionedDirectional(
              end: 20,
              child: Image.asset(
                'assets/images/sports_players.png',
                width: 130,
                height: 130,
              ),
            ),
          ),
          SizedBox(width: screenWidth * 0.015),
          BookCard(
            title: 'Connect, Chat, and Play',
            imagePath: 'assets/images/purpule_banner.png',
            subTitle: 'Message Now ',
            trailing: PositionedDirectional(
              top: 64,
              end: 0,
              child: Image.asset(
                'assets/images/chat_image.png',
                width: 100,
                height: 100,
              ),
            ),
          ),
          SizedBox(width: screenWidth * 0.015),
          BookCard(
            title: 'Find New Players ',
            imagePath: 'assets/images/green_banner.png',
            subTitle: 'Broadcast ',
            trailing: PositionedDirectional(
              top: 20,
              end: 20,
              child: Image.asset(
                'assets/images/football_players.png',
                width: 130,
                height: 130,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
