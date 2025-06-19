import 'package:book_and_play/features/owner/add_field/presentation/manager/add_field_cubit/add_field_cubit.dart';
import 'package:book_and_play/features/owner/add_field/presentation/widgets/add_field_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddFieldView extends StatelessWidget {
  const AddFieldView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddFieldCubit(),
      child: const Scaffold(body: AddFieldViewBody()),
    );
  }
}
