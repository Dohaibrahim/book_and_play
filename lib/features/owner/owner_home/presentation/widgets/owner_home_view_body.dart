import 'package:book_and_play/core/routing/routes.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/features/owner/owner_fields/presentation/manager/owner_field_cubit.dart';
import 'package:book_and_play/features/owner/owner_home/presentation/widgets/owner_fields_grid_view.dart';
import 'package:book_and_play/features/owner/owner_home/presentation/widgets/owner_tournament.dart';
import 'package:book_and_play/features/user/home/presentation/widgets/book_now.dart';
import 'package:book_and_play/features/user/home/presentation/widgets/home_app_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OwnerHomeViewBody extends StatelessWidget {
  const OwnerHomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final List<int> fields = [1, 2, 3, 4];
    final screenHight = MediaQuery.sizeOf(context).height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: screenHight * 0.02),
          HomeAppBar(),
          SizedBox(height: screenHight * 0.02),
          SizedBox(
            height: screenHight * 0.20,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                BookCard(
                  title: "owner_home.add_field_title".tr(),
                  subTitle: "owner_home.add_now".tr(),
                  trailing: SizedBox(),
                  imagePath: 'assets/images/green_banner.png',
                  onTap: () {
                    Navigator.pushNamed(context, Routes.addFieldView);
                  },
                ),
                SizedBox(width: 15),
                BookCard(
                  title: "owner_home.add_tournament_title".tr(),
                  subTitle: "owner_home.add_now".tr(),
                  trailing: SizedBox(),
                  imagePath: 'assets/images/blue_banner.png',
                  onTap: () {
                    Navigator.pushNamed(context, Routes.addTournamentView);
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: screenHight * 0.013),
          OwnerTournaments(),
          /*FieldAndMatchScore(
            screenWidth: screenWidth,
            screenHight: screenHight,
          ),*/
          SizedBox(height: screenHight * 0.025),
          Text(
            "owner_home.your_fields".tr(),
            style: TextStyles.font24BlackBold,
          ),
          SizedBox(height: screenHight * 0.02),
          BlocProvider(
            create: (context) => OwnerFieldCubit(),
            child: Expanded(child: FieldsGridView()),
          ),
        ],
      ),
    );
  }
}
