import 'package:book_and_play/core/routing/routes.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:flutter/material.dart';

class FootballFieldListView extends StatelessWidget {
  const FootballFieldListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        FootballFieldCard(),
        FootballFieldCard(),
        FootballFieldCard(),
        FootballFieldCard(),
        FootballFieldCard(),
        FootballFieldCard(),
        FootballFieldCard(),
        FootballFieldCard(),
      ],
    );
  }
}

class FootballFieldCard extends StatelessWidget {
  const FootballFieldCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.footballFieldView);
      },
      child: Column(
        children: [
          Container(
            height: 140,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/stadium_image.jpg'),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Red Meadow',

                          style: TextStyles.font24BlackBold.copyWith(
                            fontSize: 22,
                          ),
                        ),
                        Text(
                          '5x5',
                          style: TextStyles.font14BlackMedium.copyWith(
                            color: Colors.grey[700],
                          ),
                        ),
                        Text(
                          'Adoor Bypass ~1.8 km away',
                          style: TextStyles.font14BlackMedium.copyWith(
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
