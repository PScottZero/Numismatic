import 'package:flutter/material.dart';
import 'package:numismatic/model/coin.dart';

class DataInput extends StatefulWidget {
  final String label;
  final Coin coin;

  const DataInput(this.label, this.coin);

  @override
  _DataInputState createState() => _DataInputState(label, coin);
}

class _DataInputState extends State<DataInput> {
  final String label;
  final Coin coin;

  late TextEditingController _controller;

  _DataInputState(this.label, this.coin);

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
          onChanged: (value) {
            coin.setProperty(label.trim().toLowerCase(), value);
          },
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
