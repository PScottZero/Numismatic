import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Detail extends StatelessWidget {
  final String name;
  final String? value;

  const Detail({
    required this.name,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return value != null
        ? Container(
            margin: EdgeInsets.only(top: 20),
            width: double.infinity,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text(
                '$name: $value',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                ),
              ),
            ),
          )
        : Container();
  }
}
