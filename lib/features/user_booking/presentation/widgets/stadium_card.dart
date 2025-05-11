import 'package:book_and_play/core/routing/routes.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:flutter/material.dart';

class StadiumCard extends StatelessWidget {
  const StadiumCard({
    super.key,
    required this.title,
    required this.stadiumCapacity,
    required this.date,
    required this.country,
  });
  final String title, stadiumCapacity, date, country;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.userBookedFieldView);
      },
      child: Container(
        height: 150,
        width: screenWidth * 0.90,
        margin: EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: EdgeInsets.only(left: 13, top: 8, bottom: 8, right: 13),
              width: screenWidth * 0.3,
              height: 140,
              decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    offset: Offset(0, 7),
                    blurRadius: 10,
                    spreadRadius: 0,
                  ),
                ],
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/stadium_image.jpg'),
                ),
              ),
            ),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 14),
                  Text(
                    title,
                    style: TextStyles.font24BlackBold.copyWith(fontSize: 20),
                  ),

                  SizedBox(height: 6),
                  Text(
                    stadiumCapacity,
                    style: TextStyle(color: Colors.grey[700], fontSize: 14),
                  ),
                  SizedBox(height: 2),
                  Text(
                    date,
                    style: TextStyle(color: Colors.grey[700], fontSize: 14),
                  ),
                  SizedBox(height: 2),
                  Text(
                    country,
                    style: TextStyle(color: Colors.grey[700], fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StadiumCardListView extends StatelessWidget {
  const StadiumCardListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        StadiumCard(
          title: 'Shuttles Fly',
          stadiumCapacity: '5x5 (five-a-side) ',
          date: '05:00 pm - 06:30 pm, Fri 06 Sep',
          country: 'Badminton ',
        ),
        StadiumCard(
          title: 'Shuttles Fly',
          stadiumCapacity: '5x5 (five-a-side) ',
          date: '05:00 pm - 06:30 pm, Fri 06 Sep',
          country: 'Badminton ',
        ),
        StadiumCard(
          title: 'Shuttles Fly',
          stadiumCapacity: '5x5 (five-a-side) ',
          date: '05:00 pm - 06:30 pm, Fri 06 Sep',
          country: 'Badminton ',
        ),
      ],
    );
  }
}
