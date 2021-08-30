import 'package:flutter/material.dart';
import 'package:numismatic/constants/view_constants.dart';

class CoinDataTextField extends StatefulWidget {
  final String label;
  final Function(String) onChanged;

  const CoinDataTextField({required this.label, required this.onChanged});

  @override
  _CoinDataTextFieldState createState() =>
      _CoinDataTextFieldState(label, onChanged);
}

class _CoinDataTextFieldState extends State<CoinDataTextField> {
  final String label;
  final Function(String) onChanged;

  late TextEditingController _controller;

  _CoinDataTextFieldState(this.label, this.onChanged);

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        SizedBox(height: 10),
        TextField(
          controller: _controller,
          onChanged: onChanged,
          style: TextStyle(
            fontSize: ViewConstants.fontMedium,
          ),
          decoration: InputDecoration(
            contentPadding: ViewConstants.paddingAllSmall,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        SizedBox(height: ViewConstants.gapLarge),
      ],
    );
  }
}
