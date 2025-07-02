import 'package:book_and_play/features/owner/owner_fields/presentation/widgets/owner_availble_slots.dart';
import 'package:book_and_play/features/user/booking/presentation/manager/get_available_matches/get_available_matches_cubit.dart';
import 'package:book_and_play/features/user/booking/presentation/widgets/data_bokking_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OwnerMatchesViewBody extends StatelessWidget {
  const OwnerMatchesViewBody({super.key, required this.fieldId});
  final String fieldId;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    return BlocProvider(
      create: (context) => GetAvailableMatchesCubit(fieldId: fieldId),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 50),
          SizedBox(height: screenHeight * 0.07, child: DataBookingSelection()),
          SizedBox(height: 15),
          Expanded(child: OwnerAvailableSlotsListView()),
        ],
      ),
    );
  }
}
