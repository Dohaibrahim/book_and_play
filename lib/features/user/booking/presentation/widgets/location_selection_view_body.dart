import 'package:book_and_play/core/widgets/app_button.dart';
import 'package:book_and_play/features/user/booking/presentation/widgets/booking_google_map.dart';
import 'package:flutter/material.dart';

/*
class LocationSelectionViewBody extends StatefulWidget {
  const LocationSelectionViewBody({super.key});

  @override
  State<LocationSelectionViewBody> createState() =>
      _LocationSelectionViewBodyState();
}

class _LocationSelectionViewBodyState extends State<LocationSelectionViewBody> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;

    //log(bottomInset.toString());
    return Column(
      children: [
        SizedBox(
          height: screenHeight,
          width: screenWidth,
          child: Stack(
            children: [
              Positioned.fill(child: BookingGoogleMap()),
              Positioned(
                top: screenHeight * 0.08,
                right: 20,
                left: 20,
                child: SearchBar(
                  hintText: 'Search on a Football field',
                  textInputAction: TextInputAction.go,
                  onSubmitted: (value) {
                    // This gets called when "Go" is pressed on the keyboard
                    print("User searched: $value");
                  },
                ),
              ),
              Positioned(
                top: screenHeight * 0.90,
                left: 20,
                right: 20,
                child: AppButton(onPressed: () {}, text: 'Next'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}*/
