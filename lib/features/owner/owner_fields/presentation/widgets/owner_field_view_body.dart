import 'package:book_and_play/core/routing/routes.dart';
import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/core/widgets/app_button.dart';
import 'package:book_and_play/features/owner/owner_fields/data/models/owner_fields.dart';
import 'package:book_and_play/features/owner/owner_fields/presentation/widgets/delete_field_bloc_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class OwnerFieldViewBody extends StatelessWidget {
  const OwnerFieldViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final OwnerField args =
        ModalRoute.of(context)!.settings.arguments as OwnerField;
    final screenHeight = MediaQuery.sizeOf(context).height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: screenHeight * 0.50,
          child: args.image == null
              ? Image.asset(
                  'assets/images/football_stadium_demo.jpg',
                  fit: BoxFit.fill,
                )
              : Image.network(args.image!),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                args.name,
                style: TextStyles.font32BlockBold.copyWith(fontSize: 26),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Image.asset(
                    'assets/icons/maps_marker_icon.png',
                    width: 20,
                    height: 20,
                  ),
                  Text(
                    '${args.city} , ${args.country}',
                    style: TextStyles.font14BlackMedium.copyWith(
                      color: ColorManager.primaryColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Text(
                context.tr(
                  'field_capacity_label',
                  namedArgs: {'capacity': args.capacity.toString()},
                ),
                //'${args.capacity} x ${args.capacity} Football Field',
                style: TextStyles.font14BlackMedium,
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
        Expanded(child: SizedBox()),
        Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
          child: AppButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                Routes.ownerMatchesView,
                arguments: args,
              );
            },
            text: context.tr('your_matches_button'),
            textStyle: TextStyle(fontSize: 17),
          ),
        ),
        SizedBox(height: 6),
        Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
          child: AppButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                Routes.scheduleMatchView,
                arguments: args,
              );
            },
            text: context.tr('schedule_matches_button'),
            textStyle: TextStyle(fontSize: 17),
          ),
        ),
        SizedBox(height: 6),
        Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
          child: AppButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => DeleteFieldBlocProvider(args: args),
              );
            },
            text: context.tr('delete_field_button'),
            textStyle: TextStyle(fontSize: 17),
            buttonColor: Colors.red[700],
          ),
        ),
        SizedBox(height: 40),
      ],
    );
  }
}
