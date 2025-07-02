import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:book_and_play/core/widgets/app_button.dart';
import 'package:book_and_play/core/widgets/top_snackbar.dart';
import 'package:book_and_play/features/owner/matches/data/models/create_match_req.dart';
import 'package:book_and_play/features/owner/matches/presentation/manager/create_match/create_match_cubit.dart';
import 'package:book_and_play/features/owner/matches/presentation/manager/create_match/create_match_state.dart';
import 'package:book_and_play/features/owner/owner_fields/data/models/owner_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CreateMatchButton extends StatelessWidget {
  const CreateMatchButton({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.playersNum,
    required this.pickedDate,
    required this.currentPlayers,
    required this.formKey,
    required this.ownerField,
  });

  final TimeOfDay? startTime;
  final TimeOfDay? endTime;
  final int? playersNum;
  final DateTime? pickedDate;
  final List<String> currentPlayers;
  final GlobalKey<FormState> formKey;
  final OwnerField ownerField;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateMatchCubit, CreateMatchState>(
      builder: (context, state) {
        if (state is CreateMatchLoadingState) {
          return Center(
            child: CircularProgressIndicator(color: ColorManager.primaryColor),
          );
        }
        return AppButton(
          onPressed: () {
            formKey.currentState!.save();
            if (startTime != null &&
                endTime != null &&
                playersNum != null &&
                pickedDate != null) {
              context.read<CreateMatchCubit>().createMatch(
                CreateMatchReq(
                  fieldId: ownerField.id,
                  date: DateFormat('yyyy-MM-dd').format(pickedDate!),
                  time: MatchTime(
                    start: _formatTime(startTime!),
                    end: _formatTime(endTime!),
                  ),
                  location: ownerField.location,
                  maxPlayers: playersNum!,
                  currentPlayers: currentPlayers,
                  status: 'open',
                ),
              );
            } else {
              TopSnackBar.show(
                context,
                title: 'Warning',
                message: 'Please enter all required data',
                contentType: ContentType.warning,
                color: Colors.orange,
              );
            }
          },
          text: 'Add Match',
          textStyle: TextStyle(fontSize: 18),
        );
      },
    );
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
