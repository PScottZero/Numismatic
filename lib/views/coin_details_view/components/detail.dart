import 'package:flutter/material.dart';
import 'package:numislog/constants/view_constants.dart';

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
        ? Card(
            margin: EdgeInsets.only(
              top: topMargin ? ViewConstants.gapLarge : 0,
            ),
            // width: double.infinity,
            // padding:
            // decoration: BoxDecoration(
            //   borderRadius: ViewConstants.largeBorderRadius,
            // ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 18),
              child: Center(
                child: Text(
                  '$name: $value',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: ViewConstants.largeFont,
                  ),
                ),
              ),
            ),
          )
        : Container();
  }
}
