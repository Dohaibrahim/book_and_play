import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/core/widgets/app_button.dart';
import 'package:book_and_play/features/user/booking/presentation/manager/get_available_matches/get_available_matches_cubit.dart';
import 'package:book_and_play/features/user/booking/presentation/manager/get_available_matches/get_available_matches_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OwnerAvailableSlotsListView extends StatefulWidget {
  const OwnerAvailableSlotsListView({super.key});

  @override
  State<OwnerAvailableSlotsListView> createState() =>
      _OwnerAvailableSlotsListViewState();
}

class _OwnerAvailableSlotsListViewState
    extends State<OwnerAvailableSlotsListView> {
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
          return Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 15),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: 10),
                    itemCount: matches.length,
                    itemBuilder: (BuildContext context, int index) {
                      final match = matches[index];
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
                              color: Color(0xffe0f7e8),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${match.time.start} - ${match.time.end}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.delete,
                                    size: 26,
                                    color: Colors.red[700],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                AppButton(
                  onPressed: () {},
                  text: 'Add Time',
                  textStyle: TextStyle(fontSize: 17),
                ),
                SizedBox(height: 20),
              ],
            ),
          );
        } else if (state is GetAvailableMatchesFailureState) {
          return Center(
            child: Text(
              'Error: ${state.errorMessage}',
              style: TextStyles.font24BlackBold.copyWith(fontSize: 17),
            ),
          );
        }
        return Center(
          child: Text(
            'user_book.select_date_prompt'.tr(),
            style: TextStyles.font24BlackBold.copyWith(fontSize: 17),
          ),
        );
      },
    );
  }
}
