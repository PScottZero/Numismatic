import 'package:flutter/material.dart';
import 'package:numislog/constants/view_constants.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: ViewConstants.mediumBorderRadius,
      ),
      content: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            margin: const EdgeInsets.only(right: ViewConstants.gapLarge),
            child: const CircularProgressIndicator(),
          ),
          const SizedBox(
            width: 160,
            child: Text(
              'Loading coin data...',
              style: TextStyle(
                fontSize: ViewConstants.largeFont,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
