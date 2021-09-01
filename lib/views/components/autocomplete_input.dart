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
            var matching = options.where(
              (element) =>
                  element.toLowerCase().contains(pattern.toLowerCase()),
            );
            if (matching.length > 0) {
              return matching;
            }
            return [pattern];
          },
          itemBuilder: (context, suggestion) {
            return Padding(
              padding: ViewConstants.paddingAllSmall,
              child: Text(suggestion.toString()),
            );
          },
          noItemsFoundBuilder: (context) => Padding(
            padding: ViewConstants.paddingAllSmall,
            child: Text(
              'Not Found',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
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
            decoration: ViewConstants.decorationInput,
          ),
        ),
        SizedBox(height: ViewConstants.gapLarge),
      ],
    );
  }
}
