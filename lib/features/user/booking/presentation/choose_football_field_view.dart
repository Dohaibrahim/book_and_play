import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/features/user/booking/domain/usecase/fetch_fields_usecase.dart';
import 'package:book_and_play/features/user/booking/presentation/manager/fetch_fields_cubit/fetch_fields_cubit.dart';
import 'package:book_and_play/features/user/booking/presentation/widgets/booking_search_bar.dart';
import 'package:book_and_play/features/user/booking/presentation/widgets/choose_football_field_view_body.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChooseFootballFieldView extends StatelessWidget {
  const ChooseFootballFieldView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          FetchFieldsCubit(fetchFieldsUsecase: getIt<FetchFieldsUsecase>()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'user_book.browse_fields'.tr(),
            style: TextStyles.font24BlackBold.copyWith(fontSize: 22),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SearchForFields(),
        ),
      ),
    );
  }
}

class SearchForFields extends StatefulWidget {
  const SearchForFields({super.key});

  @override
  State<SearchForFields> createState() => _SearchForFieldsState();
}

class _SearchForFieldsState extends State<SearchForFields> {
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
    final screenHeight = MediaQuery.sizeOf(context).height;
    return Column(
      children: [
        BookingSearchBar(
          controller: _searchController,
          screenHeight: screenHeight,
        ),
        SizedBox(height: 20),
        Expanded(child: ChooseFootballFieldViewBody(searchText: _searchText)),
      ],
    );
  }
}
