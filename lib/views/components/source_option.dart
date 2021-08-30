import 'package:flutter/material.dart';
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

  MaterialStateProperty<T> msp<T>(T property) =>
      MaterialStateProperty.all<T>(property);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 18,
          height: 18,
          child: Radio<DataSource>(
            fillColor: msp(ViewConstants.primaryColor),
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            label,
            style: TextStyle(fontSize: ViewConstants.fontSmall),
          ),
        ),
      ],
    );
  }
}
