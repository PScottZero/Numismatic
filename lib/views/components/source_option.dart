import 'package:flutter/material.dart';
import 'package:numismatic/constants/helper_functions.dart';
import 'package:numismatic/constants/view_constants.dart';
import 'package:numismatic/model/data_source.dart';

class SourceOption extends StatelessWidget {
  final String label;
  final DataSource value;
  final DataSource groupValue;
  final Function(DataSource?) onChanged;

  SourceOption({
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: ViewConstants.radioButtonSize,
          height: ViewConstants.radioButtonSize,
          child: Radio<DataSource>(
            fillColor: HelperFunctions.msp(ViewConstants.colorPrimary),
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: ViewConstants.gapSmall),
          child: Text(
            label,
            style: TextStyle(fontSize: ViewConstants.fontSmall),
          ),
        ),
      ],
    );
  }
}
