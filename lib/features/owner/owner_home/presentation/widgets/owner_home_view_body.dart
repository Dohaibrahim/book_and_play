import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/features/owner/owner_home/presentation/widgets/field_and_match_score.dart';
import 'package:book_and_play/features/user/home/presentation/widgets/book_now.dart';
import 'package:book_and_play/features/user/home/presentation/widgets/home_app_bar.dart';
import 'package:book_and_play/features/user/home/presentation/widgets/recommended_grid_view.dart';
import 'package:flutter/material.dart';

class OwnerHomeViewBody extends StatelessWidget {
  const OwnerHomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final List<int> fields = [1, 2, 3, 4];
    final screenHight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: screenHight * 0.02),
          HomeAppBar(),
          SizedBox(height: screenHight * 0.02),
          BookCard(
            title: 'Add Football Field',
            subTitle: 'Add Now',
            trailing: SizedBox(),
            imagePath: 'assets/images/green_banner.png',
          ),
          SizedBox(height: screenHight * 0.013),
          FieldAndMatchScore(
            screenWidth: screenWidth,
            screenHight: screenHight,
          ),
          SizedBox(height: screenHight * 0.025),
          Text('Your Fields', style: TextStyles.font24BlackBold),
          SizedBox(height: screenHight * 0.02),
          Expanded(child: FieldsGridView()),
        ],
      ),
    );
  }
}

class FieldsGridView extends StatelessWidget {
  const FieldsGridView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final spacing = screenWidth * 0.07; // 5% of screen width
    final List<String> listOfImage = [
      'assets/images/football_stadium_demo.jpg',
      'assets/images/stadium_image.jpg',
      'assets/images/football_stadium_demo.jpg',
      'assets/images/stadium_image.jpg',
    ];
    final List<String> listOfNames = [
      'Red Meadows',
      'Shuttles Fly',
      'Red Meadows',
      'Shuttles Fly',
    ];
    final List<String> listOfLocations = [
      'Cairo , Egypt',
      'Badminton',
      'Cairo , Egypt',
      'Badminton',
    ];

    return
    //SizedBox(
    //height: 350, // screenHeight * 0.19,
    //child:
    GridView.builder(
      padding: EdgeInsets.all(0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: spacing,
      ),
      itemCount: listOfImage.length, // list.length,
      itemBuilder: (context, index) {
        return RecommendedItem(
          title: listOfNames[index],
          location: listOfLocations[index],
          imagePath: listOfImage[index],
        );
      },
    );
  }
}
