import 'package:flutter/material.dart';
import 'package:numismatic/constants/view_constants.dart';

class Detail extends StatelessWidget {
  final String name;
  final String? value;
  final bool topMargin;

  const Detail({
    required this.name,
    required this.value,
    this.topMargin = true,
  });

  @override
  Widget build(BuildContext context) {
    return value != null
        ? Container(
            margin: EdgeInsets.only(
              top: topMargin ? ViewConstants.gapLarge : 0,
            ),
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(15, 15, 15, 18),
            decoration: BoxDecoration(
              color: ViewConstants.colorPrimary,
              borderRadius: ViewConstants.borderRadiusMedium,
            ),
            child: Center(
              child: Text(
                '$name: $value',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: ViewConstants.fontMedium,
                  color: Colors.white,
                ),
              ),
            ),
          )
        : Container();
  }
}
