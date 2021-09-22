import 'package:flutter/material.dart';
import 'package:numismatic/constants/view_constants.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor:
          MediaQuery.of(context).platformBrightness == Brightness.dark
              ? ViewConstants.colorBackgroundAccent(context)
              : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: ViewConstants.borderRadiusMedium,
      ),
      content: Row(
        children: [
          Container(
            height: ViewConstants.progressIndicatorSize,
            width: ViewConstants.progressIndicatorSize,
            margin: const EdgeInsets.only(right: ViewConstants.gapLarge),
            child: const CircularProgressIndicator(),
          ),
          const SizedBox(
            width: ViewConstants.loadingDialogTextHeight,
            child: Text(
              'Loading coin data...',
              style: TextStyle(
                fontSize: ViewConstants.fontMedium,
                height: ViewConstants.spacing1_5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
