import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:numismatic/constants/view_constants.dart';
import 'package:numismatic/model/reference.dart';

class AutocompleteInput extends StatelessWidget {
  final String label;
  final StringReference reference;
  final List<String> options;
  final VoidCallback? refresh;
  final bool required;

  final TextEditingController _typeAheadController = TextEditingController();

  AutocompleteInput({
    required this.label,
    required this.reference,
    required this.options,
    this.refresh,
    this.required = false,
  }) {
    _typeAheadController.text = reference.value ?? '';
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
          suggestionsBoxDecoration: SuggestionsBoxDecoration(
            borderRadius: ViewConstants.borderRadiusMedium,
          ),
          itemBuilder: (context, suggestion) {
            return Padding(
              padding: ViewConstants.paddingAllMedium,
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
            reference.value = suggestion;
            if (refresh != null) refresh!();
          },
          textFieldConfiguration: TextFieldConfiguration(
            controller: _typeAheadController,
            style: TextStyle(
              fontSize: ViewConstants.fontMedium,
            ),
            decoration: ViewConstants.decorationInput(
              MediaQuery.of(context).platformBrightness,
            ),
          ),
        ),
        SizedBox(height: ViewConstants.gapLarge),
      ],
    );
  }
}
