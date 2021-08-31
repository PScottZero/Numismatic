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
            margin: EdgeInsets.only(top: ViewConstants.gapLarge),
            width: double.infinity,
            padding: ViewConstants.paddingAllMedium,
            decoration: BoxDecoration(
              color: ViewConstants.colorPrimary,
              borderRadius: ViewConstants.borderRadiusMedium,
            ),
            child: Text(
              '$name: $value',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: ViewConstants.fontMedium,
                color: Colors.white,
              ),
            ),
          )
        : Container();
  }
}
