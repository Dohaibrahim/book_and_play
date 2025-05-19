import 'package:book_and_play/core/widgets/app_text_form_field.dart';
import 'package:flutter/material.dart';

class BookingSearchBar extends StatefulWidget {
  const BookingSearchBar({super.key, required this.screenHeight});

  final double screenHeight;

  @override
  State<BookingSearchBar> createState() => _BookingSearchBarState();
}

class _BookingSearchBarState extends State<BookingSearchBar> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchText = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.screenHeight * 0.05,
      child: AppTextFormField(
        controller: _searchController,
        fillColor: Colors.grey[700],
        hintText: 'Search for a place or location',
        suffixIcon: Icon(Icons.search, size: 25),
        focusedBorderSide: BorderSide(color: Colors.grey[400]!),
        enabledBorderSide: BorderSide(color: Colors.grey[200]!),
        errorBorderSide: BorderSide(color: Colors.red),
      ),
    );
  }
}
