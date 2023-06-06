import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numislog/constants/helper_functions.dart';
import 'package:numislog/constants/view_constants.dart';

class MyElevatedButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool warning, topMargin;

  const MyElevatedButton({
    required this.label,
    required this.onPressed,
    this.warning = false,
    this.topMargin = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: topMargin ? ViewConstants.gapLarge : 0),
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          textStyle: HelperFunctions.msp(
            GoogleFonts.quicksand(fontSize: ViewConstants.largeFont),
          ),
          padding: HelperFunctions.msp(ViewConstants.largePadding),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(
            color: warning ? ViewConstants.warningColor : null,
          ),
        ),
      ),
    );
  }
}
