import 'package:flutter/material.dart';
import 'package:numismatic/model/coin_collection_model.dart';
import 'package:provider/provider.dart';

class AutocompleteInput extends StatelessWidget {
  final String label;
  final List<String> options;
  final bool required;

  const AutocompleteInput({
    required this.label,
    required this.options,
    this.required = false,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CoinCollectionModel>(
      builder: (context, model, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Text("Coin Type"),
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
                  return const Iterable<String>.empty();
                }
                return options.where(
                  (element) => element
                      .toLowerCase()
                      .contains(currentText.text.toLowerCase()),
                );
              },
              onSelected: (value) =>
                  model.currentCoin.setProperty(label, value),
              fieldViewBuilder: (context, controller, focusNode, onSubmit) {
                return TextField(
                  controller: controller,
                  focusNode: focusNode,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  onChanged: (value) => value,
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
      },
    );
  }
}
