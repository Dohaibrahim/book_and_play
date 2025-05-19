import 'package:book_and_play/core/routing/routes.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/features/booking/data/models/all_fields_res.dart';
import 'package:book_and_play/features/booking/presentation/manager/fetch_fields_cubit/fetch_fields_cubit.dart';
import 'package:book_and_play/features/booking/presentation/manager/fetch_fields_cubit/fetch_fields_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FootballFieldListView extends StatelessWidget {
  const FootballFieldListView({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<FetchFieldsCubit>().fetchFields();
    return BlocBuilder<FetchFieldsCubit, FetchFieldsState>(
      builder: (context, state) {
        if (state is FetchFieldsLoadingState) {
          return Center(child: const CircularProgressIndicator());
        } else if (state is FetchFieldsSuccessState) {
          return ListView.builder(
            itemCount: state.fields.length,
            itemBuilder: (context, index) {
              return FootballFieldCard(field: state.fields[index]);
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
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.footballFieldView);
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
                      image: AssetImage('assets/images/stadium_image.jpg'),
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
