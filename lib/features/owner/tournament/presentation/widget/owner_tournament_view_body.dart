import 'dart:developer';

import 'package:book_and_play/core/routing/routes.dart';
import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/core/widgets/app_button.dart';
import 'package:book_and_play/features/owner/tournament/presentation/manager/fetch_tournaments/fetch_tournaments_cubit.dart';
import 'package:book_and_play/features/owner/tournament/presentation/manager/fetch_tournaments/ffetch_tournaments_state.dart';
import 'package:book_and_play/features/owner/tournament/presentation/widget/tournament_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OwnerTournamentViewBody extends StatelessWidget {
  const OwnerTournamentViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<FetchTournamentsCubit>().fetchAlltournaments();
    final screenHeight = MediaQuery.sizeOf(context).height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: screenHeight * 0.10),
          Text(
            'owner_tournament.title'.tr(),
            style: TextStyles.font32BlockBold,
          ),
          SizedBox(height: 15),
          BlocBuilder<FetchTournamentsCubit, FetchTournamentsState>(
            builder: (context, state) {
              if (state is FetchTournamentsFailureState) {
                return Center(
                  child: Text(
                    'owner_tournament.error_message'.tr(),
                    style: TextStyles.font24BlackBold,
                  ),
                );
              }
              if (state is FetchTournamentsLoadingState) {
                return Expanded(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: ColorManager.primaryColor,
                    ),
                  ),
                );
              }
              if (state is FetchTournamentsSuccessState) {
                return Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: state.tournament.length,
                    itemBuilder: (context, index) {
                      return TournamentCard(
                        tournamentStatus: state
                            .tournament[index]
                            .status, //TournamentStatus.upcoming.name,
                        subTitle:
                            '${'owner_tournament.from'.tr()} ${formatDateToReadable(state.tournament[index].startDate)} ${'owner_tournament.to'.tr()} ${formatDateToReadable(state.tournament[index].endDate)}',
                        title: state.tournament[index].name,
                        onTap: () {
                          switch (state.tournament[index].status) {
                            case 'upcoming':
                              showModalBottomSheet(
                                backgroundColor: Colors.white,
                                context: context,
                                builder: (context) {
                                  return ScheduleDate(
                                    numOfTeams:
                                        state.tournament[index].maxTeams,
                                    onSubmit: (List<MatchTimeEntity> times) {
                                      for (var time in times) {
                                        log(
                                          "From: ${time.from.format(context)}, To: ${time.to.format(context)}",
                                        );
                                      }
                                    },
                                  );
                                },
                              );
                            /*Navigator.pushNamed(
                                context,
                                Routes.teamsJoinedView,
                                arguments: state.tournament[index].id,
                              );*/
                            case 'ongoing':
                              Navigator.pushNamed(
                                context,
                                Routes.teamsScheduledView,
                              );
                            case 'finished':
                              Navigator.pushNamed(
                                context,
                                Routes.teamsJoinedView,
                              );
                          }

                          //check if not startted yet , if started => validate in which round and go to it
                          //if not started => go to see teams that joined screen
                        },
                      );
                    },
                  ),
                );
              }
              return SizedBox();
            },
          ),
        ],
      ),
    );
  }

  String formatDateToReadable(DateTime inputDate) {
    List<String> months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    String day = inputDate.day.toString();
    String month = months[inputDate.month - 1];
    String year = inputDate.year.toString();

    return '$day $month $year';
  }
}

class ScheduleDate extends StatefulWidget {
  const ScheduleDate({
    super.key,
    required this.numOfTeams,
    required this.onSubmit,
  });
  final int numOfTeams;
  final void Function(List<MatchTimeEntity>) onSubmit;

  @override
  State<ScheduleDate> createState() => _ScheduleDateState();
}

class _ScheduleDateState extends State<ScheduleDate> {
  late List<MatchTimeEntity?> matchTimes;
  @override
  void initState() {
    super.initState();
    int matchCount = (widget.numOfTeams / 2).toInt();
    matchTimes = List.generate(matchCount, (_) => null);
  }

  void updateTime(int index, MatchTimeEntity time) {
    setState(() {
      matchTimes[index] = time;
    });
  }

  void saveAndPop() {
    if (matchTimes.any((t) => t == null)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select times for all matches.")),
      );
      return;
    }
    widget.onSubmit(matchTimes.cast<MatchTimeEntity>());
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 5,
              width: 75,
              decoration: BoxDecoration(
                color: Colors.grey,
                border: Border.all(color: Colors.transparent),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Set Time To Each Match ',
            style: TextStyles.font32BlockBold.copyWith(
              color: ColorManager.primaryColor,
              fontSize: 25,
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: (widget.numOfTeams / 2).toInt(),
              itemBuilder: (context, index) {
                return ShowHourRange(
                  initialTime: matchTimes[index],
                  onSelected: (time) => updateTime(index, time),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          AppButton(
            onPressed: () {
              saveAndPop();
            },
            text: 'Start The First Round',
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class ShowHourRange extends StatefulWidget {
  const ShowHourRange({super.key, required this.onSelected, this.initialTime});
  final void Function(MatchTimeEntity) onSelected;
  final MatchTimeEntity? initialTime;
  @override
  State<ShowHourRange> createState() => _ShowHourRangeState();
}

class _ShowHourRangeState extends State<ShowHourRange> {
  TimeOfDay? selectedTime;

  @override
  void initState() {
    super.initState();
    selectedTime = widget.initialTime?.from;
  }

  @override
  Widget build(BuildContext context) {
    //int endHour = selectedTime == null ? 0 : (selectedTime!.hour + 1) % 24;
    TimeOfDay endTime = selectedTime == null
        ? TimeOfDay(hour: 0, minute: 0)
        : TimeOfDay(
            hour: (selectedTime!.hour + 1) % 24,
            minute: selectedTime!.minute,
          );

    return Padding(
      padding: EdgeInsetsGeometry.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'From',
            style: TextStyles.font24BlackBold.copyWith(fontSize: 18),
          ),
          SizedBox(
            width: 140,
            height: 45,
            child: GestureDetector(
              onTap: () {
                selectedTime == null
                    ? showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      )
                    : showTimePicker(
                        context: context,
                        initialTime: selectedTime!,
                      );
              },
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff58997F),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                onPressed: () async {
                  final picked = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (picked != null) {
                    setState(() {
                      selectedTime = picked;
                    });
                    widget.onSelected(
                      MatchTimeEntity(from: picked, to: endTime),
                    );
                  }
                },
                child: Center(
                  child: Text(
                    selectedTime == null
                        ? 'select a date'
                        : selectedTime!.format(context),
                    style: TextStyle(
                      fontSize: selectedTime == null ? 13 : 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Text('To', style: TextStyles.font24BlackBold.copyWith(fontSize: 18)),
          Container(
            width: 140,
            height: 45,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: Text(
                selectedTime == null ? '00:00' : endTime.format(context),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MatchTimeEntity {
  final TimeOfDay from;
  final TimeOfDay to;

  MatchTimeEntity({required this.from, required this.to});
}
