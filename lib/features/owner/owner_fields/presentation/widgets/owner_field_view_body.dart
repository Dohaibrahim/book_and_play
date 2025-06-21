import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/core/widgets/app_button.dart';
import 'package:book_and_play/features/owner/owner_fields/data/models/owner_fields.dart';
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
          child: Image.asset(
            'assets/images/football_stadium_demo.jpg',
            fit: BoxFit.fill,
          ),
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
              Text(
                '${args.capacity} x ${args.capacity} Football Field',
                style: TextStyles.font14BlackMedium,
              ),
              SizedBox(height: 10),
              Text(
                '${args.city} , ${args.country}',
                style: TextStyles.font14BlackMedium,
              ),
            ],
          ),
        ),
        Expanded(child: SizedBox()),
        Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
          child: AppButton(onPressed: () {}, text: 'Edit Field'),
        ),
        SizedBox(height: 6),
        Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
          child: AppButton(
            onPressed: () {},
            text: 'Delete Field',
            buttonColor: Colors.red[700],
          ),
        ),
        SizedBox(height: 40),
      ],
    );
  }
}
