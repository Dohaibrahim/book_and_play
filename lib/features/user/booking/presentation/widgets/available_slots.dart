import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/core/widgets/app_button.dart';
import 'package:book_and_play/features/user/booking/presentation/manager/get_available_matches/get_available_matches_cubit.dart';
import 'package:book_and_play/features/user/booking/presentation/manager/get_available_matches/get_available_matches_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AvailableSlotsListView extends StatefulWidget {
  const AvailableSlotsListView({super.key});

  @override
  State<AvailableSlotsListView> createState() => _AvailableSlotsListViewState();
}

class _AvailableSlotsListViewState extends State<AvailableSlotsListView> {
  int? selectedIndex;
  late final List<String> dates;

  @override
  void initState() {
    dates = [
      "9:00 - 10:00 pm ",
      "3:00 - 4:00 pm ",
      "7:00 - 8:00 pm ",
      "9:00 - 10:00 am ",
      "5:00 - 6:00 pm ",
      "9:00 - 10:00 pm ",
      "3:00 - 4:00 pm ",
      "7:00 - 8:00 pm ",
      "9:00 - 10:00 am ",
      "5:00 - 6:00 pm ",
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetAvailableMatchesCubit, GetAvailableMatchesState>(
      builder: (context, state) {
        if (state is GetAvailableMatchesLoadingState) {
          return Center(
            child: CircularProgressIndicator(color: ColorManager.primaryColor),
          );
        } else if (state is GetAvailableMatchesSuccessState) {
          final matches = state.matches;
          if (matches.isEmpty) {
            return const Center(child: Text('No available matches'));
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.only(top: 10),
                  itemCount: matches.length,
                  itemBuilder: (BuildContext context, int index) {
                    final match = matches[index];

                    final isSelected = selectedIndex == index;
                    return SizedBox(
                      height: 60,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 12,
                          ),
                          decoration: BoxDecoration(
                            color:
                                isSelected
                                    ? ColorManager.primaryColor
                                    : Color(0xffe0f7e8),
                            // Color(0xffDEF0E8),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Text(
                            '${match.time.start} - ${match.time.end}',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight:
                                  isSelected
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              AppButton(onPressed: () {}, text: 'Confirm Booking'),
              SizedBox(height: 30),
            ],
          );
        } else if (state is GetAvailableMatchesFailureState) {
          return Center(
            child: Text(
              'Error: ${state.errorMessage}',
              style: TextStyles.font24BlackBold,
            ),
          );
        }
        return Center(
          child: Text(
            'Please select a date to see matches',
            style: TextStyles.font24BlackBold,
          ),
        );
      },
    );
  }
}
