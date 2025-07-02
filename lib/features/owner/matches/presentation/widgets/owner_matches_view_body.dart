import 'package:book_and_play/features/owner/matches/presentation/manager/delete_match/delete_match_cubit.dart';
import 'package:book_and_play/features/owner/matches/presentation/widgets/owner_availble_slots.dart';
import 'package:book_and_play/features/owner/owner_fields/data/models/owner_fields.dart';
import 'package:book_and_play/features/user/booking/presentation/manager/get_available_matches/get_available_matches_cubit.dart';
import 'package:book_and_play/features/user/booking/presentation/widgets/data_bokking_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OwnerMatchesViewBody extends StatelessWidget {
  const OwnerMatchesViewBody({super.key, required this.field});
  final OwnerField field;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    return BlocProvider(
      create: (context) => GetAvailableMatchesCubit(fieldId: field.id),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 50),
          SizedBox(height: screenHeight * 0.07, child: DataBookingSelection()),
          SizedBox(height: 15),
          Expanded(
            child: OwnerAvailableSlotsListView(
              ownerField: field,
              deleteMatchCubit: context.read<DeleteMatchCubit>(),
            ),
          ),
        ],
      ),
    );
  }
}
