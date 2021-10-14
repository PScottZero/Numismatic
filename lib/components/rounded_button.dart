import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numismatic/constants/helper_functions.dart';
import 'package:numismatic/constants/view_constants.dart';

class RoundedButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? color;
  final Color? textColor;
  final bool topMargin;

  const RoundedButton({
    required this.label,
    required this.onPressed,
    this.color,
    this.textColor,
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
          elevation: HelperFunctions.msp(0),
          shape: HelperFunctions.msp(
            RoundedRectangleBorder(
              borderRadius: ViewConstants.largeBorderRadius,
            ),
          ),
          backgroundColor: HelperFunctions.msp(
            color ?? ViewConstants.primaryColor,
          ),
          padding: HelperFunctions.msp(ViewConstants.largePadding),
          textStyle: HelperFunctions.msp(
            GoogleFonts.quicksand(fontSize: ViewConstants.largeFont),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(
            color: textColor ?? ViewConstants.accentColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
