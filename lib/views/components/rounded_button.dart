import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numismatic/constants/helper_functions.dart';
import 'package:numismatic/constants/view_constants.dart';

class RoundedButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? color;
  final bool topMargin;

  RoundedButton({
    required this.label,
    required this.onPressed,
    this.color,
    this.topMargin = true,
  });

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
              borderRadius: ViewConstants.borderRadiusMedium,
            ),
          ),
          backgroundColor: HelperFunctions.msp(
            color ?? ViewConstants.colorButton,
          ),
          padding: HelperFunctions.msp(ViewConstants.paddingButton),
          textStyle: HelperFunctions.msp(
            GoogleFonts.comfortaa(fontSize: ViewConstants.fontMedium),
          ),
        ),
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}
