import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:numismatic/constants/view_constants.dart';

class AutocompleteInput extends StatelessWidget {
  final String label;
  final String initialValue;
  final List<String> options;
  final Function(String) onChanged;
  final bool required;

  final TextEditingController _typeAheadController = TextEditingController();

  AutocompleteInput({
    required this.label,
    required this.initialValue,
    required this.options,
    required this.onChanged,
    this.required = false,
  }) {
    _typeAheadController.text = initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(label),
            required
                ? Text(
                    "*",
                    style: TextStyle(color: Colors.red),
                  )
                : Container()
          ],
        ),
        SizedBox(height: ViewConstants.gapSmall),
        TypeAheadField<String>(
          animationDuration: Duration.zero,
          suggestionsCallback: (pattern) {
            if (pattern == '') {
              return options;
            }
            return options.where(
              (element) =>
                  element.toLowerCase().contains(pattern.toLowerCase()),
            );
          },
          itemBuilder: (context, suggestion) {
            return Padding(
              padding: ViewConstants.paddingAllSmall,
              child: Text(suggestion.toString()),
            );
          },
          onSuggestionSelected: (suggestion) {
            _typeAheadController.text = suggestion;
            onChanged(suggestion);
          },
          textFieldConfiguration: TextFieldConfiguration(
            controller: _typeAheadController,
            autofocus: true,
            style: TextStyle(
              fontSize: ViewConstants.fontMedium,
            ),
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: ViewConstants.colorPrimary,
                  width: ViewConstants.borderWidthFocused,
                ),
                borderRadius: ViewConstants.borderRadiusMedium,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                  width: ViewConstants.borderWidthUnfocused,
                ),
                borderRadius: ViewConstants.borderRadiusMedium,
              ),
            ),
          ),
        ),
        SizedBox(height: ViewConstants.gapLarge),
      ],
    );
  }
}
