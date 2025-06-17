import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:book_and_play/core/widgets/top_snackbar.dart';
import 'package:book_and_play/features/owner/owner_fields/presentation/manager/owner_field_cubit.dart';
import 'package:book_and_play/features/owner/tournament/presentation/manager/add_tounament_cubit/add_tournament_cubit.dart';
import 'package:book_and_play/features/owner/tournament/presentation/manager/add_tounament_cubit/add_tournament_state.dart';
import 'package:book_and_play/features/owner/tournament/presentation/widget/add_tournament_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTournamentView extends StatelessWidget {
  const AddTournamentView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => OwnerFieldCubit()),
        BlocProvider(create: (context) => AddTournamentCubit()),
      ],
      child: Scaffold(
        body: BlocListener<AddTournamentCubit, AddTournamentState>(
          listener: (context, state) {
            if (state is AddTournamentSuccessState) {
              Navigator.pop(context);
              TopSnackBar.show(
                context,
                title: 'Done',
                message: 'You are added a tournament successfully!',
                contentType: ContentType.success,
                color: Color(0xff58997F),
              );
            }
          },

          child: AddTournamentViewBody(),
        ),
      ),
    );
  }
}
