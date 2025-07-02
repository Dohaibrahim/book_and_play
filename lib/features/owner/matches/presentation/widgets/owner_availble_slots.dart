import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/features/owner/matches/presentation/manager/delete_match/delete_match_cubit.dart';
import 'package:book_and_play/features/owner/matches/presentation/widgets/add_time_button.dart';
import 'package:book_and_play/features/owner/matches/presentation/widgets/delete_match_bloc_builder.dart';
import 'package:book_and_play/features/owner/owner_fields/data/models/owner_fields.dart';
import 'package:book_and_play/features/user/booking/presentation/manager/get_available_matches/get_available_matches_cubit.dart';
import 'package:book_and_play/features/user/booking/presentation/manager/get_available_matches/get_available_matches_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OwnerAvailableSlotsListView extends StatefulWidget {
  const OwnerAvailableSlotsListView({
    super.key,
    required this.deleteMatchCubit,
    required this.ownerField,
  });
  final DeleteMatchCubit deleteMatchCubit;
  final OwnerField ownerField;
  @override
  State<OwnerAvailableSlotsListView> createState() =>
      _OwnerAvailableSlotsListViewState();
}

class _OwnerAvailableSlotsListViewState
    extends State<OwnerAvailableSlotsListView> {
  int? selectedIndex;
  late final List<String> dates;
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
            return Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Center(
                      child: Text('user_book.no_available_matches'.tr()),
                    ),
                  ),
                  AddTimeButton(ownerField: widget.ownerField),
                  SizedBox(height: 50),
                ],
              ),
            );
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
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => BlocProvider.value(
                                        value: widget.deleteMatchCubit,
                                        child: DeleteMatchBlocBuilder(
                                          matchId: matches[index].id,
                                        ),
                                      ),
                                    );
                                  },
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
                AddTimeButton(ownerField: widget.ownerField),
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
