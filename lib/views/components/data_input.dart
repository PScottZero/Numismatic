import 'package:flutter/material.dart';

class DataInput extends StatefulWidget {
  final String label;
  final Function(String) onChanged;

  const DataInput({required this.label, required this.onChanged});

  @override
  _DataInputState createState() => _DataInputState(label, onChanged);
}

class _DataInputState extends State<DataInput> {
  final String label;
  final Function(String) onChanged;

  late TextEditingController _controller;

  _DataInputState(this.label, this.onChanged);

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
            fontSize: 20,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
