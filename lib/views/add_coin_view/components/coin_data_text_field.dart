import 'package:flutter/material.dart';
import 'package:numislog/constants/view_constants.dart';

class CoinDataTextField extends StatefulWidget {
  final String? label;
  final String? initialValue;
  final Function(String) onChanged;

  const CoinDataTextField({
    this.label,
    this.initialValue,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  State<CoinDataTextField> createState() => _CoinDataTextFieldState();
}

class _CoinDataTextFieldState extends State<CoinDataTextField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.initialValue ?? '';
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
        widget.label != null ? Text(widget.label!) : Container(),
        const SizedBox(height: ViewConstants.gapSmall),
        TextField(
          controller: _controller,
          onChanged: widget.onChanged,
          style: const TextStyle(fontSize: ViewConstants.largeFont),
          decoration: ViewConstants.decorationInput(context),
        ),
        const SizedBox(height: ViewConstants.gapLarge),
      ],
    );
  }
}
