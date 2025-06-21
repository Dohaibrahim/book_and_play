import 'package:book_and_play/core/routing/routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class OwnerTournaments extends StatelessWidget {
  const OwnerTournaments({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.ownerTournamentsView);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: 80,
        decoration: BoxDecoration(
          color: Color(0xffE7EFFD),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.transparent),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "owner_home.see_tournaments".tr(),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            Icon(Icons.navigate_next_outlined, color: Colors.black, size: 30),
          ],
        ),
      ),
    );
  }
}
