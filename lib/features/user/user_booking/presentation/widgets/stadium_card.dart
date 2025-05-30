import 'dart:developer';
import 'package:book_and_play/core/routing/routes.dart';
import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/features/user/user_booking/data/models/user_matches_res.dart';
import 'package:book_and_play/features/user/user_booking/presentation/manager/user_bookings_cubit.dart';
import 'package:book_and_play/features/user/user_booking/presentation/manager/user_bookings_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class StadiumCard extends StatelessWidget {
  const StadiumCard({
    super.key,
    required this.matchModel,
    required this.title,
    required this.stadiumCapacity,
    required this.date,
    required this.country,
  });
  final String title, stadiumCapacity, date, country;
  final UserMatchModel matchModel;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.userBookedFieldView,
          arguments: matchModel,
        );
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
    context.read<UserBookingsCubit>().getUserMatches();
    return BlocBuilder<UserBookingsCubit, UserBookingsState>(
      builder: (context, state) {
        if (state is UserBookingsLoadingState) {
          return Center(
            child: CircularProgressIndicator(color: ColorManager.primaryColor),
          );
        }
        if (state is UserBookingsFailureState) {
          log(state.message);
          return Center(
            child: Text(
              'There are some error that happed ,please try again later or contact our team',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
            ),
          );
        }
        if (state is UserBookingsSuccessState) {
          if (state.matches.isEmpty) {
            return Center(
              child: Text(
                'No Matches Booked Yet',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
              ),
            );
          }
          return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: state.matches.length,
            itemBuilder: (context, index) {
              return StadiumCard(
                matchModel: state.matches[index],
                title: '${state.matches[index].field.name}',
                stadiumCapacity:
                    '${state.matches[index].currentPlayers.length + 1} / ${state.matches[index].maxPlayers}',
                date:
                    '${formatTime(state.matches[index].time.start)} - ${formatTime(state.matches[index].time.start)}',
                country:
                    '${state.matches[index].field.city} - ${state.matches[index].field.country}',
              );
            },
          );
        }

        return SizedBox();
      },
    );
  }

  String formatTime(String time24) {
    final inputFormat = DateFormat("HH:mm");
    final outputFormat = DateFormat("h:mm a"); // e.g. 6:00 PM

    final time = inputFormat.parse(time24);
    return outputFormat.format(time);
  }
}
