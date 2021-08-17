import 'package:flutter/material.dart';

class DetailsTextField extends StatefulWidget {
  final String defaultText;
  final int maxLines;

  const DetailsTextField(
    this.defaultText, {
    this.maxLines = 1,
    Key? key,
  }) : super(key: key);

  @override
  _DetailsTextFieldState createState() =>
      _DetailsTextFieldState(defaultText, maxLines);
}

class _DetailsTextFieldState extends State<DetailsTextField> {
  String defaultText;
  int maxLines;
  late TextEditingController _controller;

  _DetailsTextFieldState(this.defaultText, this.maxLines);

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.text = defaultText;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        controller: _controller,
        onSubmitted: (value) {},
        maxLines: null,
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
