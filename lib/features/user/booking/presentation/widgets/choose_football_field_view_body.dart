import 'package:book_and_play/features/user/booking/presentation/widgets/football_field_list_view.dart';
import 'package:flutter/material.dart';

class ChooseFootballFieldViewBody extends StatelessWidget {
  const ChooseFootballFieldViewBody({super.key, required this.searchText});
  final String searchText;
  @override
  Widget build(BuildContext context) {
    return FootballFieldListView(searchText: searchText);
  }
}
