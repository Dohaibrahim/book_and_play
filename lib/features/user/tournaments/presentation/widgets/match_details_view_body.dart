import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/core/widgets/app_button.dart';
import 'package:book_and_play/features/owner/tournament/data/models/teams_matches_res.dart';
import 'package:book_and_play/features/owner/tournament/presentation/widget/match_card.dart';
import 'package:book_and_play/features/user/booking/presentation/manager/fetch_field_by_id/fetch_field_by_id_cubit.dart';
import 'package:book_and_play/features/user/booking/presentation/manager/fetch_field_by_id/fetch_field_by_id_state.dart';
import 'package:book_and_play/features/user/booking/presentation/widgets/football_field_view_body.dart';
import 'package:book_and_play/features/user/booking/presentation/widgets/location_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MatchDetailsViewBody extends StatelessWidget {
  const MatchDetailsViewBody({super.key, required this.match});
  final MatchScheduled match;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    context.read<FetchFieldByIdCubit>().getFieldById();
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 70),
          Text(
            'match_details.title'.tr(),
            style: TextStyles.font24BlackBold,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 210,
            child: MatchCard(
              teamsAName: match.teamA.name,
              date: formatDate(match.date),
              time: '${match.time.start} - ${match.time.end}',
              score: match.score.teamA == null
                  ? 'match_details.not_played'.tr()
                  : '${match.score.teamA} - ${match.score.teamB}',
              teamsBName: match.teamB.name,
            ),
          ),
          SizedBox(height: 10),
          BlocBuilder<FetchFieldByIdCubit, FetchFieldByIdState>(
            builder: (context, state) {
              if (state is FetchFieldByIdLoadingState) {
                return Center(
                  child: CircularProgressIndicator(
                    color: ColorManager.primaryColor,
                  ),
                );
              }
              if (state is FetchFieldByIdSuccessState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      '${'match_details.field_name'.tr()} : ${state.field.name}',
                      style: TextStyles.font24BlackBold.copyWith(fontSize: 22),
                    ),
                    Row(
                      children: [
                        Image.asset(
                          'assets/icons/maps_marker_icon.png',
                          width: 30,
                          height: 30,
                        ),
                        Text(
                          '${state.field.city} , ${state.field.country}',
                          style: TextStyles.font14BlackMedium.copyWith(
                            color: ColorManager.primaryColor,
                          ),
                        ),
                        Expanded(child: SizedBox()),
                      ],
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      height: screenHeight * 0.04,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'user_book.location_info'.tr(),
                            style: TextStyles.font24BlackBold,
                          ),
                          LocationButton(
                            latitude: state.field.location.coordinates[0],
                            longitude: state.field.location.coordinates[1],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      state.field.locationInfo ??
                          'match_details.no_location_info'.tr(),
                      style: TextStyles.font14BlackMedium.copyWith(
                        color: Colors.grey[700],
                        fontSize: 16,
                      ),
                    ),
                    state.field.amenities.isNotEmpty
                        ? Text(
                            'user_book.amenities'.tr(),
                            style: TextStyles.font24BlackBold,
                          )
                        : SizedBox(),
                    state.field.amenities.isNotEmpty
                        ? Expanded(
                            child: AmenitiesListView(
                              amenties: state.field.amenities,
                            ),
                          )
                        : SizedBox(),
                    state.field.amenities.isNotEmpty
                        ? SizedBox(height: screenHeight * 0.20)
                        : SizedBox(height: screenHeight * 0.33),
                    AppButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      text: 'match_details.done'.tr(),
                      textStyle: TextStyles.font24BlackBold.copyWith(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 50),
                  ],
                );
              }
              return SizedBox();
            },
          ),
        ],
      ),
    );
  }

  String formatDate(DateTime date) {
    return DateFormat('d MMMM').format(date);
  }
}
