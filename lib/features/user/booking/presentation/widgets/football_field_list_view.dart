import 'package:book_and_play/core/routing/routes.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/features/user/booking/data/models/all_fields_res.dart';
import 'package:book_and_play/features/user/booking/presentation/manager/fetch_fields_cubit/fetch_fields_cubit.dart';
import 'package:book_and_play/features/user/booking/presentation/manager/fetch_fields_cubit/fetch_fields_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FootballFieldListView extends StatelessWidget {
  const FootballFieldListView({super.key, required this.searchText});
  final String searchText;
  @override
  Widget build(BuildContext context) {
    context.read<FetchFieldsCubit>().fetchFields();
    return BlocBuilder<FetchFieldsCubit, FetchFieldsState>(
      builder: (context, state) {
        if (state is FetchFieldsLoadingState) {
          return Center(child: const CircularProgressIndicator());
        } else if (state is FetchFieldsSuccessState) {
          List<Field> fields;
          fields = state.fields.where((item) {
            final searchLower = searchText.toLowerCase();
            return item.name.toLowerCase().contains(searchLower) ||
                item.city.toLowerCase().contains(searchLower) ||
                item.country.toLowerCase().contains(searchLower);
          }).toList();
          if (fields.isEmpty) {
            return Center(
              child: Text(
                'search.no_results'.tr(namedArgs: {'query': searchText}),
                //'No results found for "$searchText"',
                style: TextStyles.font14BlackMedium,
              ),
            );
          }
          return ListView.builder(
            itemCount: fields.length,
            itemBuilder: (context, index) {
              return FootballFieldCard(field: fields[index]);
            },
          );
        }
        return SizedBox();
      },
    );
  }
}

class FootballFieldCard extends StatelessWidget {
  const FootballFieldCard({super.key, required this.field});
  final Field field;
  @override
  Widget build(BuildContext context) {
    final imageProvider = (field.image != null && field.image!.isNotEmpty)
        ? NetworkImage(field.image!)
        : AssetImage('assets/images/football_stadium_demo.jpg')
              as ImageProvider;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.footballFieldView,
          arguments: field.id,
        );
      },
      child: Column(
        children: [
          Container(
            height: 140,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: imageProvider,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          field.name,
                          style: TextStyles.font24BlackBold.copyWith(
                            fontSize: 22,
                          ),
                        ),
                        Text(
                          '${field.capacity} x ${field.capacity}',
                          style: TextStyles.font14BlackMedium.copyWith(
                            color: Colors.grey[700],
                          ),
                        ),
                        Text(
                          '${field.city} , ${field.country}  ', //'Adoor Bypass ~1.8 km away',
                          style: TextStyles.font14BlackMedium.copyWith(
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
