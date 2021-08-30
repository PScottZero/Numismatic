import 'package:flutter/material.dart';
import 'package:numismatic/constants/view_constants.dart';

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
            padding: ViewConstants.paddingAllMedium,
            decoration: BoxDecoration(
              color: Colors.blue[300],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              '$name: $value',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                color: Colors.white,
              ),
            ),
          )
        : Container();
  }
}
