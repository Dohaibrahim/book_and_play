import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class NumberOfTeams extends StatefulWidget {
  const NumberOfTeams({
    super.key,
    required this.onChanged,
    required this.value,
  });
  final void Function(String?)? onChanged;
  final String? value;
  @override
  State<NumberOfTeams> createState() => _NumberOfTeamsState();
}

class _NumberOfTeamsState extends State<NumberOfTeams> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        hint: Text('number of teams'),
        items: ['8', '16']
            .map(
              (item) =>
                  DropdownMenuItem<String>(value: item, child: Text(item)),
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
      ),
    );
  }
}
