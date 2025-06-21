import 'package:book_and_play/features/owner/owner_fields/data/models/owner_fields.dart';
import 'package:book_and_play/features/owner/owner_fields/presentation/manager/owner_field_cubit.dart';
import 'package:book_and_play/features/owner/owner_fields/presentation/manager/owner_field_state.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddFieldDropButton extends StatefulWidget {
  const AddFieldDropButton({
    super.key,
    required this.onChanged,
    required this.value,
  });
  final OwnerField? value;
  final void Function(OwnerField?)? onChanged;

  @override
  State<AddFieldDropButton> createState() => _AddFieldDropButtonState();
}

class _AddFieldDropButtonState extends State<AddFieldDropButton> {
  @override
  void initState() {
    context.read<OwnerFieldCubit>().getFields();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //context.read<OwnerFieldCubit>().getFields();
    return BlocBuilder<OwnerFieldCubit, OwnerFieldState>(
      builder: (context, state) {
        if (state is OwnerFieldFailueState) {
          return SizedBox();
        }
        if (state is OwnerFieldLoadingState) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is OwnerFieldSuccessState) {
          return DropdownButtonHideUnderline(
            child: DropdownButton2(
              isExpanded: true,
              hint: Text('owner_home.add_field'.tr()),
              items: state.fields
                  //['8', '16']
                  .map(
                    (item) => DropdownMenuItem<OwnerField>(
                      value: item,
                      child: SizedBox(
                        height: 100,
                        child: ListTile(
                          minTileHeight: 100,
                          title: Text(
                            item.name,
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text('${item.city} - ${item.country}'),
                        ),
                      ),
                    ),
                  )
                  .toList(),
              value: widget.value,
              onChanged: widget.onChanged,
              buttonStyleData: ButtonStyleData(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.transparent),
                  color: Colors.grey[200],
                ),
              ),
              dropdownStyleData: DropdownStyleData(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
              ),
              menuItemStyleData: MenuItemStyleData(
                height: 80,
                padding: EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          );
        }
        return SizedBox();
      },
    );
  }
}
