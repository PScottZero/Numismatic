import 'package:flutter/material.dart';

class AutocompleteInput extends StatelessWidget {
  final String label;
  final String initialValue;
  final List<String> options;
  final Function(String) onChanged;
  final bool required;

  AutocompleteInput({
    required this.label,
    required this.initialValue,
    required this.options,
    required this.onChanged,
    this.required = false,
  });

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
        SizedBox(height: 10),
        Autocomplete<String>(
          optionsBuilder: (currentText) {
            if (currentText.text == '') {
              return options;
            }
            return options.where(
              (element) => element
                  .toLowerCase()
                  .contains(currentText.text.toLowerCase()),
            );
          },
          onSelected: onChanged,
          fieldViewBuilder: (context, controller, focusNode, onSubmit) {
            controller..text = initialValue;
            return TextField(
              controller: controller,
              focusNode: focusNode,
              style: TextStyle(
                fontSize: 20,
              ),
              onChanged: onChanged,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          },
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
