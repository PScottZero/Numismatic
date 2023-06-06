import 'package:flutter/material.dart';
import 'package:numislog/constants/view_constants.dart';
import 'package:numislog/model/data_source.dart';

class SourceOption extends StatelessWidget {
  final String label;
  final DataSource value;
  final DataSource groupValue;
  final Function(DataSource?) onChanged;

  const SourceOption({
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 18,
          height: 18,
          child: Radio<DataSource>(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: ViewConstants.gapSmall),
          child: Text(
            label,
            style: const TextStyle(fontSize: ViewConstants.mediumFont),
          ),
        ),
      ],
    );
  }
}
