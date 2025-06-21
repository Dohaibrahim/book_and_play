import 'package:book_and_play/core/routing/routes.dart';
import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:book_and_play/features/owner/owner_fields/presentation/manager/owner_field_cubit.dart';
import 'package:book_and_play/features/owner/owner_fields/presentation/manager/owner_field_state.dart';
import 'package:book_and_play/features/user/home/presentation/widgets/recommended_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    Routes.ownerFieldView,
                    arguments: state.fields[index],
                  );
                },
                capacity:
                    '${state.fields[index].capacity} x ${state.fields[index].capacity} players',
                title: state.fields[index].name,
                location:
                    '${state.fields[index].city} - ${state.fields[index].country}',
                imagePath: listOfImage[index % 2],
              );
            },
          );
        }
        return SizedBox();
      },
    );
  }
}
