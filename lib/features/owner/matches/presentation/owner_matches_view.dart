import 'package:book_and_play/features/owner/matches/presentation/manager/delete_match/delete_match_cubit.dart';
import 'package:book_and_play/features/owner/matches/presentation/widgets/owner_matches_view_body.dart';
import 'package:book_and_play/features/owner/owner_fields/data/models/owner_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OwnerMatchesView extends StatelessWidget {
  const OwnerMatchesView({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as OwnerField;
    return BlocProvider(
      create: (context) => DeleteMatchCubit(),
      child: Scaffold(
        body: SafeArea(child: OwnerMatchesViewBody(field: args)),
      ),
    );
  }
}
