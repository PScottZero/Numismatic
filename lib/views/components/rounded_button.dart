import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RoundedButton extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final Color? color;

  RoundedButton({required this.label, required this.onPressed, this.color});

  MaterialStateProperty<T> msp<T>(T property) =>
      MaterialStateProperty.all<T>(property);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: msp(0),
          shape: msp(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          backgroundColor: msp(color),
          padding: msp(EdgeInsets.only(top: 20, bottom: 17)),
          textStyle: msp(GoogleFonts.comfortaa(fontSize: 22)),
        ),
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}
