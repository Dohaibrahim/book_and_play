import 'package:book_and_play/features/owner/add_field/presentation/manager/get_places_cubit/get_places_cubit.dart';
import 'package:book_and_play/features/owner/add_field/presentation/widgets/pick_location_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PickLocationView extends StatelessWidget {
  const PickLocationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetPlacesCubit(),
      child: const Scaffold(body: PickLocationViewBody()),
    );
  }
}
