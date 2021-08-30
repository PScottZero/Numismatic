import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numismatic/constants/view_constants.dart';
import 'package:numismatic/model/data_source.dart';

import 'source_option.dart';

class MultiSourceTextField extends StatefulWidget {
  final String label;
  final String initialValueManual;
  final DataSource initialDataSource;
  final Function(String) onChanged;
  final Function(DataSource?) onRadioChanged;

  const MultiSourceTextField({
    required this.label,
    required this.initialValueManual,
    required this.initialDataSource,
    required this.onChanged,
    required this.onRadioChanged,
  });

  @override
  _MultiSourceTextFieldState createState() => _MultiSourceTextFieldState(
        label,
        initialValueManual,
        initialDataSource,
        onChanged,
        onRadioChanged,
      );
}

class _MultiSourceTextFieldState extends State<MultiSourceTextField> {
  final String label;
  final String manualInitialValue;
  final DataSource initialDataSource;
  final Function(String) onChanged;
  final Function(DataSource?) onRadioChanged;
  late TextEditingController _controller;
  DataSource _source = DataSource.auto;

  _MultiSourceTextFieldState(
    this.label,
    this.manualInitialValue,
    this.initialDataSource,
    this.onChanged,
    this.onRadioChanged,
  ) {
    _source = initialDataSource;
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController()..text = manualInitialValue;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  changeDataSource(DataSource? source) {
    setState(() {
      _source = source ?? DataSource.auto;
    });
    onRadioChanged(source);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        SizedBox(height: ViewConstants.gapSmall),
        Padding(
          padding: EdgeInsets.only(bottom: ViewConstants.gapSmall),
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
            ? Column(
                children: [
                  TextField(
                    controller: _controller,
                    onChanged: onChanged,
                    style: TextStyle(
                      fontSize: ViewConstants.fontMedium,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: ViewConstants.gapSmall),
                ],
              )
            : Container(),
        SizedBox(height: ViewConstants.gapSmall),
      ],
    );
  }
}
