import 'package:book_and_play/core/routing/routes.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/features/home/presentation/widgets/book_now.dart';
import 'package:book_and_play/features/home/presentation/widgets/browse_your_booking.dart';
import 'package:book_and_play/features/home/presentation/widgets/home_app_bar.dart';
import 'package:book_and_play/features/home/presentation/widgets/recommended_grid_view.dart';
import 'package:flutter/material.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHight = MediaQuery.sizeOf(context).height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: ListView(
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          HomeAppBar(),
          SizedBox(height: screenHight * 0.03),
          BookNowListView(),
          SizedBox(height: screenHight * 0.03),
          Text(
            'Your Booking',
            style: TextStyles.font24BlackBold.copyWith(fontSize: 20),
          ),
          SizedBox(height: screenHight * 0.007),
          BrowseYourBooking(
            onTap: () {
              Navigator.pushNamed(context, Routes.userBookingView);
            },
            title: 'Browse your booking',
            trailing: Icon(
              Icons.navigate_next_outlined,
              color: Colors.black,
              size: 30,
            ),
          ),
          SizedBox(height: screenHight * 0.03),
          Text(
            'Recommended For You',
            style: TextStyles.font24BlackBold.copyWith(fontSize: 20),
          ),
          SizedBox(height: screenHight * 0.007),
          RecommendedGridView(),
        ],
      ),
    );
  }
}
