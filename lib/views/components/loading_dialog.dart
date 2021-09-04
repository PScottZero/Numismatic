import 'package:flutter/material.dart';
import 'package:numismatic/constants/view_constants.dart';

class LoadingDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: ViewConstants.borderRadiusMedium,
      ),
      content: Container(
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              margin: EdgeInsets.only(right: ViewConstants.gapLarge),
              child: CircularProgressIndicator(),
            ),
            Container(
              width: 160,
              child: Text(
                'Loading coin data...',
                style: TextStyle(
                  fontSize: ViewConstants.fontMedium,
                  height: ViewConstants.spacing1_5,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
