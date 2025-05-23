import 'dart:developer';

import 'package:book_and_play/features/user/booking/presentation/manager/fetch_field_by_id/fetch_field_by_id_cubit.dart';
import 'package:book_and_play/features/user/booking/presentation/widgets/football_field_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FootballFieldView extends StatelessWidget {
  const FootballFieldView({super.key, this.fieldId});
  final String? fieldId;

  @override
  Widget build(BuildContext context) {
    log('id : ${fieldId}');
    return BlocProvider(
      create: (context) => FetchFieldByIdCubit(fieldId: fieldId),
      child: const Scaffold(body: FootballFieldViewBody()),
    );
  }
}
