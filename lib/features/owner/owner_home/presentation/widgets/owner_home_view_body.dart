import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/features/owner/owner_fields/presentation/manager/owner_field_cubit.dart';
import 'package:book_and_play/features/owner/owner_fields/presentation/manager/owner_field_state.dart';
import 'package:book_and_play/features/owner/owner_home/presentation/widgets/field_and_match_score.dart';
import 'package:book_and_play/features/user/home/presentation/widgets/book_now.dart';
import 'package:book_and_play/features/user/home/presentation/widgets/home_app_bar.dart';
import 'package:book_and_play/features/user/home/presentation/widgets/recommended_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          BlocProvider(
            create: (context) => OwnerFieldCubit(),
            child: Expanded(child: FieldsGridView()),
          ),
        ],
      ),
    );
  }
}

class FieldsGridView extends StatelessWidget {
  const FieldsGridView({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<OwnerFieldCubit>().getFields();
    final screenWidth = MediaQuery.of(context).size.width;
    final spacing = screenWidth * 0.07; // 5% of screen width
    final List<String> listOfImage = [
      'assets/images/football_stadium_demo.jpg',
      'assets/images/stadium_image.jpg',
      'assets/images/football_stadium_demo.jpg',
      'assets/images/stadium_image.jpg',
    ];

    return BlocBuilder<OwnerFieldCubit, OwnerFieldState>(
      builder: (context, state) {
        if (state is OwnerFieldLoadingState) {
          return Center(
            child: CircularProgressIndicator(color: ColorManager.primaryColor),
          );
        }
        if (state is OwnerFieldFailueState) {
          return Center(
            child: Text('There are an error occured , please contact our team'),
          );
        }

        if (state is OwnerFieldSuccessState) {
          return GridView.builder(
            padding: EdgeInsets.all(0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: spacing,
            ),
            itemCount: state.fields.length, // list.length,
            itemBuilder: (context, index) {
              return RecommendedItem(
                capacity:
                    '${state.fields[index].capacity} x ${state.fields[index].capacity} players',
                title: state.fields[index].name,
                location:
                    '${state.fields[index].city} - ${state.fields[index].country}',
                imagePath: listOfImage[index],
              );
            },
          );
        }
        return SizedBox();
      },
    );
  }
}
