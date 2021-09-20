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
            padding: ViewConstants.detailPadding,
            decoration: BoxDecoration(
              color: ViewConstants.colorPrimary,
              borderRadius: ViewConstants.borderRadiusLarge,
            ),
            child: Center(
              child: Text(
                '$name: $value',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: ViewConstants.fontMedium,
                  fontWeight: FontWeight.bold,
                  color: ViewConstants.colorAccent,
                ),
              ),
            ),
          )
        : Container();
  }
}
