import 'package:flutter/material.dart';

class AutocompleteInput extends StatelessWidget {
  final String label;
  final List<String> options;
  final Function(String) onChanged;
  final Function()? onTap;
  final int Function(String, String)? comparator;
  final bool required;

  AutocompleteInput({
    required this.label,
    required this.options,
    required this.onChanged,
    this.comparator,
    this.onTap,
    this.required = false,
  }) {
    comparator != null ? options.sort(comparator) : options.sort();
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
            return TextField(
              controller: controller,
              focusNode: focusNode,
              style: TextStyle(
                fontSize: 20,
              ),
              onChanged: onChanged,
              onTap: onTap,
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
