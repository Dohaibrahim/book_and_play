import 'dart:developer';

import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:flutter/material.dart';

class RecommendedItem extends StatelessWidget {
  const RecommendedItem({
    super.key,
    required this.imagePath,
    required this.title,
    required this.rateNum,
    required this.location,
  });
  final String imagePath, title, rateNum, location;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.8,
      child: SizedBox(
        height: 250,
        width: 300,
        child: Stack(
          children: [
            Positioned(
              child: Container(
                height: 150, // screenHeight * 0.19,
                width: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(imagePath),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 5,
              top: 120,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 7, vertical: 6),
                height: 100,

                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      offset: Offset(0, 3),
                      blurRadius: 8,
                      spreadRadius: 0,
                    ),
                  ],
                  color: Colors.white,
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        ImageIcon(
                          AssetImage('assets/icons/star_icon.png'),
                          color: ColorManager.primaryColor,
                          size: 17,
                        ),
                        Text(
                          rateNum,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 7),
                    Text(
                      location,
                      style: TextStyle(color: Colors.grey[700], fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RecommendedGridView extends StatelessWidget {
  const RecommendedGridView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final spacing = screenWidth * 0.07; // 5% of screen width
    final List<String> listOfImage = [
      'assets/images/football_stadium_demo.jpg',
      'assets/images/stadium_image.jpg',
    ];
    final List<String> listOfNames = ['Red Meadows', 'Shuttles Fly'];
    final List<String> listOfLocations = ['Cairo , Egypt', 'Badminton'];
    final List<String> listOfRates = ['4.0', '4.2'];
    //final screenHeight = MediaQuery.sizeOf(context).height;
    return SizedBox(
      height: 250, // screenHeight * 0.19,
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.5,
          crossAxisSpacing: spacing,
        ),
        itemCount: listOfImage.length, // list.length,
        itemBuilder: (context, index) {
          return RecommendedItem(
            title: listOfNames[index],
            location: listOfLocations[index],
            rateNum: listOfRates[index],
            imagePath: listOfImage[index],
          );
        },
      ),
    );
  }
}
