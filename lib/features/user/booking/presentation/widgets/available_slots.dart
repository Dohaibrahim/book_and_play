import 'dart:developer';

import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/core/widgets/app_button.dart';
import 'package:book_and_play/core/widgets/app_dialog.dart';
import 'package:book_and_play/features/user/booking/presentation/manager/get_available_matches/get_available_matches_cubit.dart';
import 'package:book_and_play/features/user/booking/presentation/manager/get_available_matches/get_available_matches_state.dart';
import 'package:book_and_play/features/user/booking/presentation/manager/join_match/join_match_cubit.dart';
import 'package:book_and_play/features/user/booking/presentation/manager/join_match/join_match_state.dart';
import 'package:easy_localization/easy_localization.dart';
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
  String? matchId;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    return BlocBuilder<GetAvailableMatchesCubit, GetAvailableMatchesState>(
      builder: (context, state) {
        if (state is GetAvailableMatchesLoadingState) {
          return Center(
            child: CircularProgressIndicator(color: ColorManager.primaryColor),
          );
        } else if (state is GetAvailableMatchesSuccessState) {
          final matches = state.matches;
          if (matches.isEmpty) {
            return Center(child: Text('user_book.no_available_matches'.tr()));
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
                            matchId = match.id;
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
                            color: isSelected
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
                              fontWeight: isSelected
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
              BlocConsumer<JoinMatchCubit, JoinMatchState>(
                builder: (context, state) {
                  return AppButton(
                    onPressed: () {
                      if (matchId == null) {
                        log('match id == 0');
                      } else {
                        context.read<JoinMatchCubit>().joinMatch(matchId!);
                      }
                    },
                    text: 'user_book.confirm_booking'.tr(),
                  );
                },
                listener: (context, state) {
                  if (state is JoinMatchFailureState) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AppDialog(
                          subTitle: state
                              .errorMessage, //'You already have booked this match',
                          title: 'user_book.error_booking_title'.tr(),
                          imagePath: 'assets/icons/error_icon.png',
                          screenHeight: screenHeight,
                          screenWidth: screenWidth,
                        );
                      },
                    );
                  } else if (state is JoinMatchSuccessState) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AppDialog(
                          screenHeight: screenHeight,
                          screenWidth: screenWidth,
                          imagePath: 'assets/icons/success_icon.png',
                          title: 'user_book.success_booking_title'.tr(),
                          subTitle: 'user_book.success_booking_sub'.tr(),
                        );
                      },
                    );
                  }
                },
              ),
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
            'user_book.select_date_prompt'.tr(),
            style: TextStyles.font24BlackBold,
          ),
        );
      },
    );
  }
}
