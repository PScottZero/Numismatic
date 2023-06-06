import 'package:flutter/material.dart';
import 'package:numislog/constants/view_constants.dart';
import 'package:numislog/model/data_source.dart';

import 'source_option.dart';

class MultiSourceField<T> extends StatefulWidget {
  final String label;
  final DataSource initialDataSource;
  final Widget manualChild;
  final Function(DataSource?) onRadioChanged;

  const MultiSourceField({
    required this.label,
    required this.initialDataSource,
    required this.manualChild,
    required this.onRadioChanged,
    Key? key,
  }) : super(key: key);

  @override
  State<MultiSourceField> createState() => _MultiSourceFieldState();
}

class _MultiSourceFieldState extends State<MultiSourceField> {
  DataSource _source = DataSource.auto;

  changeDataSource(DataSource? source) {
    setState(() {
      _source = source ?? DataSource.auto;
    });
    widget.onRadioChanged(source);
  }

  @override
  void initState() {
    super.initState();
    _source = widget.initialDataSource;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label),
        const SizedBox(height: ViewConstants.gapSmall),
        Padding(
          padding: const EdgeInsets.only(bottom: ViewConstants.gapSmall),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SourceOption(
                label: 'Auto',
                value: DataSource.auto,
                groupValue: _source,
                onChanged: changeDataSource,
              ),
              SourceOption(
                label: 'Manual',
                value: DataSource.manual,
                groupValue: _source,
                onChanged: changeDataSource,
              ),
              SourceOption(
                label: 'None',
                value: DataSource.none,
                groupValue: _source,
                onChanged: changeDataSource,
              ),
            ],
          ),
        ),
        _source == DataSource.manual
            ? widget.manualChild
            : const SizedBox(height: ViewConstants.gapSmall),
      ],
    );
  }
}
