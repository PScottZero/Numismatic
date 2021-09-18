import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:numismatic/constants/view_constants.dart';
import 'package:numismatic/model/reference.dart';

class AutocompleteInput extends StatelessWidget {
  final String? label;
  final StringReference reference;
  final List<String> options;
  final InputDecoration decoration;
  final double fontSize;
  final Color? fontColor;
  final VoidCallback? refresh;
  final bool required;
  final bool padding;

  final TextEditingController _typeAheadController = TextEditingController();

  AutocompleteInput({
    this.label,
    required this.reference,
    required this.options,
    required this.decoration,
    this.fontSize = ViewConstants.fontMedium,
    this.fontColor,
    this.refresh,
    this.required = false,
    this.padding = true,
    Key? key,
  }) : super(key: key) {
    _typeAheadController.text = reference.value;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            label != null ? Text(label!) : Container(),
            required
                ? const Text(
                    "*",
                    style: TextStyle(color: Colors.red),
                  )
                : Container()
          ],
        ),
        padding ? const SizedBox(height: ViewConstants.gapSmall) : Container(),
        TypeAheadField<String>(
          animationDuration: Duration.zero,
          suggestionsCallback: (pattern) {
            if (pattern == '') {
              return options;
            }
            var matching = options.where(
              (element) =>
                  element.toLowerCase().contains(pattern.toLowerCase()),
            );
            if (matching.isNotEmpty) {
              return matching.toList();
            }
            return [pattern];
          },
          suggestionsBoxDecoration: SuggestionsBoxDecoration(
            borderRadius: ViewConstants.borderRadiusMedium,
            color: ViewConstants.colorBackgroundAccent,
          ),
          itemBuilder: (context, suggestion) {
            return Container(
              padding: ViewConstants.paddingAllMedium,
              child: Text(suggestion.toString()),
            );
          },
          noItemsFoundBuilder: (context) => const Padding(
            padding: ViewConstants.paddingAllSmall,
            child: Text(
              'Not Found',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          onSuggestionSelected: (suggestion) {
            reference.value = suggestion;
            if (refresh != null) {
              refresh!();
            }
          },
          textFieldConfiguration: TextFieldConfiguration(
            controller: _typeAheadController,
            style: TextStyle(
              fontSize: fontSize,
              color: fontColor,
            ),
            decoration: decoration,
            onSubmitted: (value) {
              reference.value = value;
              if (refresh != null) {
                refresh!();
              }
            },
            onChanged: (value) {
              reference.value = value;
              if (value == '') {
                if (refresh != null) {
                  refresh!();
                }
              }
            },
          ),
        ),
        padding ? const SizedBox(height: ViewConstants.gapLarge) : Container(),
      ],
    );
  }
}
