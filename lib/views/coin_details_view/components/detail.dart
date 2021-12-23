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
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return value != null
        ? Container(
            margin: EdgeInsets.only(
              top: topMargin ? ViewConstants.gapLarge : 0,
            ),
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 18),
            decoration: BoxDecoration(
              color: ViewConstants.primaryColor,
              borderRadius: ViewConstants.largeBorderRadius,
            ),
            child: Center(
              child: Text(
                '$name: $value',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: ViewConstants.largeFont,
                  fontWeight: FontWeight.bold,
                  color: ViewConstants.accentColor,
                ),
              ),
            ),
          )
        : Container();
  }
}
