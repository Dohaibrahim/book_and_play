import 'package:book_and_play/core/routing/routes.dart';
import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/features/user/home/presentation/widgets/book_now.dart';
import 'package:book_and_play/features/user/home/presentation/widgets/browse_your_booking.dart';
import 'package:book_and_play/features/user/home/presentation/widgets/home_app_bar.dart';
import 'package:book_and_play/features/user/home/presentation/widgets/latest_tournaments.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHight = MediaQuery.sizeOf(context).height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          HomeAppBar(),
          SizedBox(height: screenHight * 0.03),
          BookNowListView(),
          SizedBox(height: screenHight * 0.03),
          Text(
            'home.your_booking'.tr(),
            style: TextStyles.font24BlackBold.copyWith(fontSize: 20),
          ),
          SizedBox(height: screenHight * 0.007),
          BrowseYourBooking(
            onTap: () {
              Navigator.pushNamed(context, Routes.userBookingView);
            },
            title: 'home.browse_your_booking'.tr(),
            trailing: Icon(
              Icons.navigate_next_outlined,
              color: Colors.black,
              size: 30,
            ),
          ),
          SizedBox(height: screenHight * 0.03),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'home.recommended'.tr(),
                style: TextStyles.font24BlackBold.copyWith(fontSize: 20),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.tournamentsView);
                },
                child: Text(
                  'home.see_all'.tr(),
                  style: TextStyles.font14BlackMedium.copyWith(
                    color: ColorManager.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: screenHight * 0.007),
          Expanded(child: LatestTournaments(fetchAll: false)),
        ],
      ),
    );
  }
}
